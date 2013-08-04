//Animated Helicrashs for DayZ 1.7.6.1
//Version 0.2
//Release Date: 05. April 2013
//Author: Grafzahl
//Thread-URL: http://opendayz.net/threads/animated-helicrashs-0-1-release.9084/

private["_useStatic","_crashDamage","_lootRadius","_preWaypoints","_preWaypointPos","_endTime","_startTime","_heliStart","_deadBody","_exploRange","_heliModel","_lootPos","_list","_craters","_dummy","_wp2","_wp3","_landingzone","_aigroup","_wp","_helipilot","_crash","_crashwreck","_smokerand","_staticcoords","_pos","_dir","_position","_num","_config","_itemType","_itemChance","_weights","_index","_iArray","_crashModel","_lootTable","_guaranteedLoot","_randomizedLoot","_frequency","_variance","_spawnChance","_spawnMarker","_spawnRadius","_spawnFire","_permanentFire","_crashName", "_aaa", "_blacklist"];

//_crashModel	= _this select 0;
//_lootTable	= _this select 1;
_guaranteedLoot = _this select 0;
_randomizedLoot = _this select 1;
_frequency	= _this select 2;
_variance	= _this select 3;
_spawnChance	= _this select 4;
_spawnMarker	= _this select 5;
_spawnRadius	= _this select 6;
_spawnFire	= _this select 7;
_fadeFire	= _this select 8;
_randomizedWP	= _this select 9;
_guaranteedWP	= _this select 10;

_chutetype = "ParachuteMediumEast";
_boxtype = "Misc_cargo_cont_net1";
_useStatic = false;





if(count _this > 11) then {
	_crashDamage = _this select 11;
} else {
	_crashDamage = 1;
};


diag_log(format["PLANE: Starting spawn logic for animated AN2 Carepackage drops - written by Grafzahl, modded by fofinho [CD:%1]", _crashDamage]);

while {true} do {

	_preWaypoints = round(random _randomizedWP) + _guaranteedWP;
	
	private["_timeAdjust","_timeToSpawn","_spawnRoll","_crash","_hasAdjustment","_newHeight","_adjustedPos"];
	// Allows the variance to act as +/- from the spawn frequency timer
	_timeAdjust = round(random(_variance * 2) - _variance);
	_timeToSpawn = time + _frequency + _timeAdjust;

	//Random Heli-Type
	_heliModel = "AN2_DZ";

	//Random-Startpositions, Adjust this for other Maps then Chernarus
	_heliStart = [[1200.212, 11457.625, 496.43225],[1200.212, 11457.625, 496.43225]] call BIS_fnc_selectRandom;


	_crashName	= getText (configFile >> "CfgVehicles" >> _heliModel >> "displayName");

	diag_log(format["PLANE: %1%2 chance to start a %3 Carepackagedrop at %4 with %5 drop points", round(_spawnChance * 100), '%', _crashName, _timeToSpawn, _preWaypoints]);

	// Apprehensive about using one giant long sleep here given server time variances over the life of the server daemon
	while {time < _timeToSpawn} do {
		sleep 5;
	};

	_spawnRoll = random 1;

	// Percentage roll
	if (_spawnRoll <= _spawnChance) then {

		//Spawn the AI-Heli flying in the air
		_startTime = time;
		_crashwreck = createVehicle [_heliModel,_heliStart, [], 0, "FLY"];

		//Make sure its not destroyed by the Hacker-Killing-Cleanup (Thanks to Sarge for the hint)
		_crashwreck setVariable["Sarge",1];

		_crashwreck engineOn true;
		_crashwreck flyInHeight 100;
		_crashwreck forceSpeed 160;
		_crashwreck setspeedmode "NORMAL";

		/*
		//Create an Invisibile Landingpad at the Crashside-Coordinates
		_landingzone = createVehicle ["HeliHEmpty", [_position select 0, _position select 1], [], 0, "CAN_COLLIDE"];
		_landingzone setVariable["Sarge",1];
		*/
		
		//Only a Woman could crash a Heli this way...
		_aigroup = creategroup civilian;
		_helipilot = _aigroup createUnit ["SurvivorW2_DZ",getPos _crashwreck,[],0,"FORM"];
		_helipilot moveindriver _crashwreck;
		_helipilot assignAsDriver _crashwreck;

		sleep 0.5;

		
		_unsorted = [];
		
		for "_x" from 1 to _preWaypoints do {
			
			_preWaypointPos = [[10012.521,2396.499],	[10015.738,2208.2996],	[10021.914,5378.7012],	[10023.425,2549.0269],	[10036.173,2488.7173],	[10056.138,3173.6655],	[10088.851,2440.0781],	[10107.079,2262.5647],	[10125.198,2825.0308],	[10125.198,3130.0864],	[10139.737,2687.0278],	[10157.911,2984.8215],	[10161.546,3239.0352],	[10186.989,2490.9209],	[10203.359,2314.3625],	[10209.222,2759.0103],	[10210.75,2848.2971],	[10229.082,2679.644],	[1024.5175,4488.4385],	[10252.415,2607.1326],	[10262.688,2818.5352],	[1027.7411,2365.8242],	[10297.17,2374.7927],	[10333.378,4989.71],	[1034.1887,4311.2871],	[1037.4124,3744.396],	[10375.73,2715.5117],	[10378.457,4731.7476],	[1040.6362,3615.5586],	[1040.6362,3870.0137],	[1043.86,4169.5645],	[1050.3074,4005.2957],	[10560.562,2648.356],	[1059.9788,2700.8047],	[10626.467,2544.8804],	[10626.467,2717.3391],	[10725.325,2660.8987],	[1092.2162,2459.2329],	[11027.12,4868.1758],	[11064.085,4988.2095],	[11142.637,4817.3916],	[11142.637,5195.9609],	[11188.847,9549.5088],	[11207.328,9424.8564],	[11216.567,5038.9932],	[1124.4537,4649.4873],	[11281.259,5177.4941],	[11281.259,9609.5254],	[11287.993,6765.1797],	[11304.768,7603.6313],	[11337.863,6872.8052],	[1134.125,2620.2805],	[11341.327,9489.4902],	[11345.949,5043.6108],	[11347.501,7493.519],	[11357.812,6761.1934],	[11375.765,7173.7603],	[11375.765,7287.3652],	[11377.76,7100.0161],	[11383.745,7002.356],	[11390.235,7578.9131],	[11399.23,7715.9912],	[11406.019,9664.9258],	[11411.672,6689.4424],	[11411.672,6868.8188],	[11417.656,7287.3652],	[11435.608,6763.1865],	[11447.578,7175.7529],	[11449.573,7092.0439],	[11452.225,9290.9727],	[11453.563,6986.4102],	[11466.087,9535.6572],	[11489.469,7269.4272],	[11493.695,7338.4624],	[11498.43,5643.7813],	[11499.442,6870.812],	[11505.428,7165.7876],	[11507.422,7078.0918],	[11515.401,6976.4458],	[11516.187,7644.0801],	[11523.381,6767.1719],	[11527.37,6685.4561],	[1153.4677,3866.7939],	[11537.345,7265.4419],	[11544.64,9669.542],	[11553.881,9207.8721],	[11558.501,5500.6621],	[11576.984,9023.2051],	[11590.408,7315.9907],	[11601.178,6876.7915],	[11604.708,5639.1631],	[11605.167,6779.1304],	[11610.65,7594.6426],	[11613.948,9540.2744],	[11623.191,9120.1553],	[11633.142,7399.1372],	[11643.068,6693.4287],	[11646.294,8953.9541],	[11646.294,9355.6074],	[11647.09,6572.6733],	[11651.135,7282.2842],	[11662.38,7165.4297],	[11669.397,5491.4302],	[11682.623,7551.9463],	[11687.881,9055.5215],	[11697.122,9678.7754],	[11707.362,7358.6875],	[11718.609,7259.8115],	[11734.087,5657.6313],	[11747.95,9309.4395],	[1176.0339,4021.3999],	[1176.0339,4124.4707],	[1176.0339,4250.0884],	[11763.592,7329.4746],	[11765.841,7214.8682],	[11766.433,8967.8037],	[11817.261,9387.9238],	[11835.564,7280.0361],	[11835.743,9651.0752],	[11858.847,8898.5537],	[11872.71,9526.4248],	[11965.123,9577.209],	[11978.985,9438.708],	[12009.645,8746.459],	[12052.847,8872.2539],	[12063.956,8692.1943],	[1208.2715,2494.6628],	[12096.049,8805.6563],	[12114.87,8555.8799],	[12115.799,8890.752],	[12125.811,7480.6934],	[12161.718,6924.626],	[12165.708,6791.0889],	[12176.636,9242.7168],	[12181.665,7404.957],	[12182.746,8490.251],	[12185.655,7107.9878],	[12191.64,7004.3481],	[12203.608,7522.5483],	[12209.021,8358.9922],	[12221.563,6735.2827],	[12223.557,6840.9165],	[12226.891,8916.6523],	[12238,8816.7559],	[12247.494,7472.7217],	[12249.33,9333.5078],	[12249.489,6936.5835],	[12265.447,7127.9194],	[12267.442,7034.2446],	[12289.842,8890.752],	[12293.375,6850.8818],	[12295.37,7430.8667],	[12303.42,8795.79],	[12311.329,6745.2485],	[12321.303,6972.4595],	[12329.779,9285.5488],	[12332.932,9384.3506],	[12339.256,7066.1333],	[12343.246,7143.8633],	[12348.058,8580.4619],	[12350.841,8488.6885],	[12371.718,8405.2568],	[12376.247,8857.4541],	[12383.141,6870.812],	[12391.015,9199.3379],	[12391.059,8772.3574],	[12405.084,7086.0645],	[12411.892,9296.6738],	[12415.058,7004.3481],	[12417.054,6773.1519],	[12425.032,7369.0815],	[12427.434,9409.7715],	[12432.767,8972.6826],	[12432.953,8590.1963],	[12441.304,8417.7725],	[12448.263,8510.9365],	[12454.011,8800.7227],	[12454.955,6874.7983],	[12459.21,9195.166],	[12464.776,9093.6582],	[12474.903,7000.3618],	[12482.401,8731.6592],	[12490.861,7359.1157],	[12494.189,8416.3809],	[12494.85,6789.0957],	[12496.786,9288.3311],	[12514.668,9395.2441],	[12515.065,8599.9297],	[12521.837,9075.5801],	[12522.022,8510.9365],	[12530.188,8883.6875],	[12534.063,4464.167],	[12537.146,8958.7773],	[12549.857,8334.3398],	[12551.064,9177.0889],	[12563.288,4409.937],	[12588.641,9057.5039],	[12594.207,8836.4111],	[12600.271,8021.6069],	[12601.352,8421.9434],	[12601.352,8601.3203],	[12602.558,9263.3018],	[12606.92,8502.5928],	[12612,4457.2139],	[12612.3,8957.3857],	[12620.077,9358.9287],	[12638.743,9100.6113],	[12640.756,8075.5391],	[12667.668,4423.8418],	[12674.493,8019.3604],	[12676.319,9214.6328],	[1269.5227,4040.7249],	[12690.237,8822.5059],	[12693.02,8985.1973],	[12718.071,9100.6113],	[12721.852,9337.1396],	[12723.974,8156.4385],	[12733.221,5667.9189],	[12737.469,7808.1245],	[12753.213,7904.7529],	[12755.276,5807.4976],	[12755.461,7985.6523],	[12761.833,9210.0322],	[12798.182,9297.1914],	[12804.227,5607.1099],	[12828.816,5774.5596],	[12854.175,5853.1045],	[12892.215,5759.3574],	[12900.591,5566.5703],	[12926.914,7127.5049],	[12950.54,5901.2446],	[12962.298,7300.7402],	[12973.362,5812.5649],	[1298.5365,3667.0935],	[12996.186,5706.1494],	[13026.617,5911.3799],	[13033.067,6708.5596],	[13064.655,5782.1611],	[13072.263,5668.144],	[13077.297,6614.8721],	[1311.4316,3886.1196],	[13135.684,6544.1646],	[1314.6554,4688.1392],	[13149.836,6627.2461],	[13150.876,5746.689],	[13166.091,5622.5381],	[13169.298,6705.0249],	[13176.376,6805.7842],	[13204.683,6575.9829],	[13220.605,6459.3145],	[13227.682,6627.2461],	[1327.5503,3760.502],	[13273.683,6530.0225],	[13296.683,6577.75],	[13314.375,6443.4053],	[1363.0116,4572.1846],	[1382.3541,5274.354],	[1395.2491,4433.6826],	[1437.158,3480.2783],	[1508.0806,5193.8296],	[1514.528,3567.2441],	[1556.4368,5277.5747],	[1630.5831,3332.114],	[1646.7019,4501.3228],	[1649.9257,4356.3804],	[1656.373,2816.76],	[1666.0444,3164.6238],	[1672.4918,5290.459],	[1691.8345,2311.0684],	[1695.0581,5184.167],	[1701.5057,2923.0508],	[1772.4283,2265.9751],	[1775.652,3180.7288],	[1811.1134,2858.6316],	[1836.9034,3667.0935],	[1840.1272,2961.7026],	[1843.351,5023.1187],	[1862.6935,4420.7988],	[1917.4973,3760.502],	[1940.0636,4159.9009],	[1952.9585,4027.8423],	[1959.4061,5161.6206],	[1988.4199,2984.2493],	[2010.9861,2858.6316],	[2020.6575,4195.3315],	[2069.0137,4043.9465],	[2120.5938,4195.3315],	[2133.4885,4585.0679],	[2139.9363,5100.4229],	[2152.8315,2829.644],	[2159.2788,2704.0264],	[2172.1738,2981.0283],	[2178.6213,4043.9465],	[2181.8452,4952.2588],	[2207.635,4198.5527],	[2243.0964,4694.5806],	[2278.5576,4082.5981],	[2297.9001,5039.2236],	[2365.5991,4784.7676],	[2433.2979,5164.8413],	[2478.4304,4804.0942],	[2678.3032,3406.1958],	[2687.9744,3229.043],	[2704.093,2098.4858],	[2720.2119,2385.1511],	[2729.8833,4849.1875],	[2762.1206,2926.2725],	[2768.5681,2807.0974],	[2787.9106,3431.9641],	[2791.1343,4968.3628],	[2820.1484,3039.0061],	[2836.2668,4845.9658],	[2839.491,2381.9292],	[2849.1621,5064.9922],	[2852.3857,2819.9807],	[2858.8335,2916.6091],	[2910.4136,5164.8413],	[2926.5322,4987.6875],	[2932.9797,3448.0684],	[2949.0986,4839.5244],	[2965.217,4188.8892],	[3000.6787,4027.8423],	[3032.9163,4974.8052],	[3042.5872,5116.5273],	[3049.0347,4311.2871],	[3052.2588,3451.2891],	[3084.4961,4759],	[3090.9436,3940.8755],	[3116.7336,4926.4902],	[3123.1812,3296.6831],	[3126.4048,2823.2017],	[3129.6284,2246.6492],	[3148.9712,4359.6001],	[3161.866,2681.4797],	[3165.0898,5061.7705],	[3171.5374,3000.3552],	[3184.4326,3873.2354],	[3190.8799,3206.4963],	[3197.3271,4224.3203],	[3210.2224,4900.7227],	[3219.8933,4101.9243],	[3223.1177,4684.918],	[3232.7888,5016.6768],	[3236.0127,4391.8105],	[3248.9077,3383.6489],	[3265.0259,3290.2415],	[3287.5928,2700.8047],	[3297.2639,4781.5469],	[3303.7114,3039.0061],	[3332.7253,4179.2266],	[3335.9492,3470.615],	[3339.1726,4056.8298],	[3361.7388,2729.793],	[3374.6338,3357.8813],	[3400.4243,3564.0225],	[3481.0178,2877.9575],	[3515.2795,4817.0171],	[3580.7053,4791.5957],	[3606.7439,2832.864],	[3667.9402,4780.7007],	[3700.6528,4922.3345],	[3713.1279,2787.7708],	[3733.3655,4751.6484],	[3745.3657,2681.4797],	[3791.522,5053.0718],	[3793.7219,2884.3999],	[3813.3308,4886.0186],	[3838.7744,4715.3311],	[3838.7744,5220.1274],	[3874.3159,2990.6919],	[3875.1218,4570.0664],	[3907.8347,5045.8101],	[3929.6433,4882.3867],	[3944.1824,4693.5425],	[3945.2385,2932.7151],	[3947.8171,5263.707],	[3958.7214,5172.916],	[3964.5808,3051.8894],	[4027.782,4620.9092],	[4027.782,5074.8623],	[4032.28,2694.363],	[4089.5737,4922.3345],	[4090.3071,3003.5752],	[4112.8735,2794.2134],	[4154.7822,2658.9331],	[4167.6772,2935.9351],	[4180.4424,5085.7573],	[4196.6914,2758.7822],	[4202.252,3669.4243],	[4257.9424,2900.5042],	[4267.6772,4944.124],	[4283.7324,2723.3516],	[4333.1035,3716.6355],	[4358.5469,3829.2161],	[4373.9976,2684.6997],	[4377.2217,2845.7483],	[4387.625,4827.9136],	[4432.0254,2800.6548],	[4451.3677,2546.1987],	[4461.0391,2636.3855],	[4511.2075,4798.8604],	[4594.8071,4519.2251],	[4685.6768,4544.6465],	[4692.9458,4424.8032],	[4700.2158,2529.094],	[4772.9111,2485.5149],	[4772.9111,4777.0708],	[4783.8149,4639.0684],	[4801.9888,4384.855],	[4823.7979,4519.2251],	[4834.7017,2460.0933],	[4867.415,4010.7971],	[4914.667,2401.9875],	[4921.9365,5354.5005],	[4980.0928,3720.2673],	[4994.6318,2362.0396],	[4994.6318,4083.4297],	[5023.71,5260.0752],	[5074.5967,3629.4763],	[5081.8667,2329.3552],	[5103.6748,3959.9541],	[5114.5796,4090.6934],	[5136.3882,3738.4258],	[5140.0234,5281.8667],	[5169.1006,2274.8813],	[5190.9092,3585.8972],	[5216.3525,3800.1626],	[5234.5273,2234.9331],	[5241.7959,3912.7441],	[5270.874,4054.3772],	[5347.2041,3920.0071],	[5379.918,3633.1091],	[5394.457,4058.0081],	[5459.8828,3963.5862],	[5461.1934,2694.4097],	[5530.2549,2545.5129],	[5555.6982,2665.3574],	[5642.9326,2483.7754],	[5661.1055,2636.3032],	[5730.167,2469.2485],	[5755.6104,2650.8298],	[5824.6709,2509.1968],	[5868.2881,2658.0928],	[5908.2705,2578.1973],	[5966.4277,3718.5278],	[6039.1221,3210.0999],	[6039.1221,3507.8933],	[6042.7568,3631.3677],	[6086.374,3141.0991],	[6115.4531,3319.0483],	[6122.7217,3722.1587],	[6155.4346,2919.5701],	[6155.4346,3220.9956],	[6180.8779,3388.0491],	[6191.7832,3053.9402],	[6224.4961,3609.5791],	[6228.1309,2763.4104],	[6228.1309,3722.1587],	[6239.0352,3260.9426],	[6253.5742,2966.781],	[6271.748,3133.8354],	[6297.1914,2839.6738],	[6297.1914,3544.2095],	[6333.5391,3206.4688],	[6333.5391,3685.8425],	[6355.3477,3053.9402],	[6380.791,3529.6829],	[6402.5996,2937.7285],	[6409.8691,3653.1582],	[6420.7734,3119.3096],	[6543.3887,3090.575],	[6573.0137,3026.4451],	[6581.6533,3126.3401],	[6587.9736,4749.9106],	[6608.8086,3079.4761],	[6609.7813,3722.1597],	[6617.0508,3602.3164],	[6632.2617,3033.8442],	[6645.8398,3125.1069],	[6660.6689,4677.2773],	[6672.9961,3051.1104],	[6705.0889,3136.2065],	[6707.9209,3605.9482],	[6718.666,3058.5095],	[6729.7295,3736.6865],	[6744.2686,4637.3291],	[6744.5879,3133.7393],	[6748.291,3077.0095],	[6787.8848,3613.2109],	[6795.1553,3743.9502],	[6806.0596,4604.6445],	[6808.3828,2887.0486],	[6856.5527,2923.145],	[6867.5,2861.8909],	[6871.4854,3747.5811],	[6878.7559,3613.2109],	[6911.291,2900.1755],	[6912.3857,2835.6392],	[6922.2393,2972.3667],	[6926.0068,5283.7583],	[6952.8916,2875.0168],	[6952.8916,2927.5205],	[6955.082,2994.2432],	[6987.7988,3613.2109],	[6998.7031,3747.5811],	[7005.4414,2905.644],	[7018.5791,2976.7429],	[7048.1377,2936.271],	[7049.5898,5294.6538],	[7089.5713,3613.2109],	[7118.876,2800.7346],	[7129.5547,3496.9985],	[7142.5342,3380.3706],	[7150.8857,2838.2786],	[7151.3633,3751.2131],	[7151.3633,5298.2852],	[7153.6689,2654.729],	[7166.1943,2772.9236],	[7200.9863,3246.8794],	[7202.3789,2688.1018],	[7216.2969,2795.1729],	[7221.8633,3392.8848],	[7224.0576,3489.7366],	[7224.0576,3620.4749],	[7237.1729,2724.2551],	[7256.7705,5301.917],	[7260.4063,5153.021],	[7260.8311,3298.3291],	[7282.2139,3754.845],	[7299.7998,3388.7129],	[7304.0234,3507.8943],	[7307.6592,5011.3872],	[7340.3721,3624.1067],	[7387.623,3754.845],	[7387.623,4909.7021],	[7409.4326,5283.7583],	[7442.1445,3515.1582],	[7460.3193,3631.3696],	[7547.5527,3518.7891],	[7562.0928,3638.6326],	[7562.8486,3405.3965],	[7569.3623,4764.4365],	[7576.6309,4880.6479],	[7627.5186,4717.2256],	[7642.1777,3415.1304],	[7652.9619,3522.4199],	[7660.2305,4499.3281],	[7671.1348,4826.1738],	[7674.7695,3638.6326],	[7740.1963,3536.9468],	[7747.4658,4484.8013],	[7758.3701,5178.4424],	[7841.9697,3562.3682],	[7852.873,5247.4429],	[7885.5869,5098.5459],	[7929.2041,5320.0752],	[7961.917,5094.9141],	[7965.5508,5192.9683],	[7972.8223,3533.3157],	[8070.96,3475.21],	[8078.2295,5243.811],	[8169.0996,5142.125],	[8234.5244,5029.5449],	[8285.4121,4935.1226],	[8314.4902,3242.7859],	[8339.9336,3101.1521],	[8390.8213,3184.6792],	[8417.6035,3004.9329],	[8463.5156,3079.3625],	[8870.6094,4103.4795],	[9092.3311,3802.0552],	[9219.5469,2323.9846],	[9241.3555,4067.1643],	[9252.2598,2469.2495],	[9292.2432,2323.9846],	[9321.3203,2451.0918],	[9328.5898,2625.4092],	[9346.7646,3940.0571],	[9357.6689,2302.1951],	[9390.3818,2443.8281],	[9408.5557,3460.6833],	[9419.459,3217.3645],	[9423.0947,3337.208],	[9426.7285,2618.1465],	[9437.6328,2305.8262],	[9444.9023,2193.2456],	[9450.4883,2119.7588],	[9484.8857,2443.8281],	[9510.3301,2309.458],	[9550.3115,2429.3015],	[9552.2236,2101.821],	[9561.2168,2614.5144],	[9624.0361,2099.8279],	[9685.876,2099.8279],	[9694.0586,3568.8684],	[9745.7188,2109.7944],	[9833.4902,2133.7097],	[9857.9863,5489.2568],	[9918.0156,2505.4468],	[9931.7549,5415.5527],	[9955.1738,2165.6003],	[9965.2686,2367.4448]] call BIS_fnc_selectRandom;
			
			_unsorted = _unsorted + [_preWaypointPos];
			
			};


			
			
		_sorted = [];
		_pos = [800,2400];

	{
     _closest = _unsorted select 0;
     {if ((_x distance _pos) <= (_closest distance _pos)) then {_closest = _x}} forEach _unsorted;
	 
     _sorted = _sorted + [_closest];

	_helper = [];
	_i=0;
	while {!([_helper, _closest] call BIS_fnc_areEqual)} do { 
		_helper = _unsorted select _i;
		_i=_i+1;
		};

	_unsorted set [(_i-1),"delete_me"];
	_unsorted = _unsorted - ["delete_me"];
	} forEach _unsorted;
			
	diag_log(format["PLANE: %1 started flying from %2 to first waypoint NOW!(TIME:%3)", _crashName,  str(_heliStart), round(time)]);
		

		
		for "_x" from 0 to ((count _sorted)-1) do {
		
			
			//_preWaypointPos = [_spawnMarker,0,8000,10,0,1000,0,_blacklist] call BIS_fnc_findSafePos;
			diag_log(format["PLANE: Adding DROPWaypoint #%1 on %2", (_x+1),str(_sorted select _x)]);
			_wp = _aigroup addWaypoint [(_sorted select _x), 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointBehaviour "CARELESS";
			
			
			waituntil {(_crashwreck distance (_sorted select _x)) <= 250 || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};	
			
			diag_log(format["PLANE IS AT DROPWAYPOINT #%1 on %2", (_x+1),str(getpos _crashwreck)]);
			sleep 2;
			nul = [_chutetype, _boxtype, _helistart, _crashwreck, _randomizedLoot, _guaranteedLoot] spawn server_carepackagedrop;
			
			if (not alive _crashwreck || (damage _crashwreck) >= _crashDamage || (getPosATL _crashwreck select 2) < 5 ) exitWith {diag_log(format["DROPPED 1 LAST PACKAGE WHILE GETTING SHOT DOWN #%1 on %2", _x,str(getpos _crashwreck)]); };
			
		};
		
		
		_wp2 = _aigroup addWaypoint [_heliStart, 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointBehaviour "CARELESS";
		diag_log(format["PLANE IS AT END WAYPOINT on %1",str(_heliStart)]);
		waituntil {(_crashwreck distance _heliStart) <= 1000 || not alive _crashwreck || (getPosATL _crashwreck select 2) < 5 || (damage _crashwreck) >= _crashDamage};
		
		sleep 5;	
		
		//Clean Up the Crashsite
		deletevehicle _crashwreck;
		deletevehicle _helipilot;
		diag_log(format["PLANE DELETED"]);
	
		
		
		_endTime = time - _startTime;
		diag_log(format["PLANE: %2 Carepackagedrops completed! Runtime: %1 Seconds", round(_endTime), _preWaypoints]);
		
	
	};
		

};