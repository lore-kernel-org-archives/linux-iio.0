Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023081.outbound.protection.outlook.com [52.101.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C84369A
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054319; cv=fail; b=Aph+JZtKCBFsVtSzRJPQcgOJHCnAs54S43J+MpVbeAwf1LPMjdNEdQVINxLZP0M+aPbFTGnrrgEYVh8ZvHX3dXyFC7WcQTFQbIl7ANPhEj77KRJNC6Fh2t4zhx8IcjMFa0fYdQ4tps0Dz7AYHh8x3aaSKaJClYONDWW8/9Nwz28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054319; c=relaxed/simple;
	bh=ANsOGbbaEBTi/Hdnj8Igu653eFpELe+Coc7lciN7pKg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=icl95gvWhs9Ph6E2ljv6abZF78bwP27OrreQsssOwQmrgen5n57jP8Qzs4GEjZU/TsEaV8/XXl7fT65j1SuIYi3xwqHQajxJLnxDA6HrF8BLkKkTKiUZG9veRT7YwP1/fgFoViaBJcca1SdKKuGnqadwpHH4YPUNHG6ylHHOJHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=eUDHnG+X; arc=fail smtp.client-ip=52.101.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="eUDHnG+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd0N6D9HYptxU43lOZh+R8I9GaZbzI0KPvkMG/tD/vFupUmWxPuuQSbF9e2YLPhYuidraKr3QcUWYIn1SxaxufHd02uuq4wp4eo2CouELQJYNLvk0sbNO+eFfqJAHJQX2BVGADU3I+4Av5VdlbhYa7LQss8OjohZLBLoHlnsOkU/1cXfBClsg7nE8zAZTDodW59I/AJNzYLOWDlJqcOB8bynvIfVtgCjaTuA/tFU9/UZ+M12Od/Vs0JOdy6DTnpkMCGnuP05TACFhWU33oFT4N1iB/re/HHHKMpD/FbLpO6BtsdMToEH4X9IUCw/8/NPXZ1PV71R8kIMOLX8WA1Hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nedds8LWZ659CVaYDibvzH+UjfBKRQFs7nBv9zobQmw=;
 b=G/SMkxf5iP+Ug71003Domjq0uWIy4RbtIDNJW1STV4KocyuBH3nIwsAxUuNPP36+4XAR2xlyuTe9mNmQ1hXD0Bnl1O7jue6gWmsisInmOGERAf1D7cGoNOzvZxKRVSk6LABJEhSBJka7qFAuYzNaj0kplCFG41hkYYAvHohPC/EaU+fHv7fOir4CO1dnUZ4fvEgCFw7WZn2zXZdjywrIUD/HCHCPjQFPQfWvwguY+Fj6NHTQtvXnbV1BvSsz9zCXJYnjNy7os2dMcREGG/7IGPQvcg6cf2oVdgJbMfxi9tj9VXXDL7xs4YDtRiOEU8+CdDPqr/I3gXTptkAXdSorIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nedds8LWZ659CVaYDibvzH+UjfBKRQFs7nBv9zobQmw=;
 b=eUDHnG+XvmPBcM0egpiQqGQCFmkAvc7SVS/UFhFJYn+Rz7KC4lGrJmBywJCh1NJ+9noceTSC49bP8MTpHuOUt7ZZVxv5FDPBa3h6z2IPbCVgeSu0FAyinkC6VLG0y1mT/gu6G3EWcWloXAsM6bLNmTZLkzakiZ3afealhohdK+x9nShTtfiuMrfISofpW8H6NjK3nW+nZGugLFFxEVSaNoxkJXJt/ySn2p761CKQJUYeDlKsb0I0037WueOpfogsvGyk1mORpuhaMP6riaiHns6zyuxytQvdy2wiBOHLRHNx8UzBBpKThtRZW4xbGJtd54ry5f+62zOepI/OeDweAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by FRWPR06MB9858.eurprd06.prod.outlook.com (2603:10a6:d10:173::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:45:08 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 17:45:08 +0000
Message-ID: <039aa848-98f3-4d1f-849e-dbba563bfc10@vaisala.com>
Date: Mon, 2 Feb 2026 19:45:04 +0200
User-Agent: Mozilla Thunderbird
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PULL] IIO: New device support, features and cleanup for 7.0
To: Greg KH <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
References: <20260201165951.481378da@jic23-huawei>
 <2026020249-neurotic-resolved-aad7@gregkh>
Content-Language: en-US
In-Reply-To: <2026020249-neurotic-resolved-aad7@gregkh>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: GVX0EPF0005F731.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2d3) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|FRWPR06MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: b723ad5f-6b2d-4449-ce25-08de6282cea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkRkUmc0UXc4TU9ESEMxWWVEdS9yN2duakFxTG1tek1IOW5nQU1Ya3Y5MnpO?=
 =?utf-8?B?Z2dBRGlUTmxWbDR5Z2E0blNrc3pwMVd0SHhXazJOeUJTSTdONTJkQktxdkNm?=
 =?utf-8?B?aTVjQW9kbmxZeGJiZHhsc0s3dEo0TzdUY241N1hNWlhTSzdaRXRKcFZiMHF2?=
 =?utf-8?B?OEhNbjM1c2hHQVRIS1B6WGx5Y01XZVdJelQ3eXJYVTJ3VEZiVytreXVlM3Bx?=
 =?utf-8?B?ZDkxSlRqZ0RaeXp6QUpib0hmenNJMlAva2JqNWdTR3RYcXpGYWlRNnFsME9m?=
 =?utf-8?B?UnBNN2pseGVHSjFaZXhuVE1ES3BzZG5CR2tNL0ViTHNRU0RqOG1ZVXdYSWpY?=
 =?utf-8?B?UXgxdFdRU0N1R2gxcUlsR1VVZXU3QVk3RnVzd21oZnBRWE5ud3pvMW1kZjcw?=
 =?utf-8?B?d1Q4WUEyQTZOc0taN2gwM2VSUlhpRUh4a05RYnZkU2FxQjYyYTBBeW1lS0lu?=
 =?utf-8?B?K0JwbXBTOHlHZE5DakNVb0NqNHd3b3JSQmxzdGNCM1dvL2JaTm9JV2pONDZH?=
 =?utf-8?B?U0JaY054ajVlMkFGcXF5QVR0QU8xVVVjTHJnd1BDRGpqZXNtMzl1a0JiSVFo?=
 =?utf-8?B?eSs4ZWdJNG1KQjlscVc2d2FQVm5xR21RR2w0SDlNZWVpZDUvRHExV3BDTDZy?=
 =?utf-8?B?Q3pLV1BaZm9CV3lpVnJjZmpyT2tWK0dZMHg4byt4enNHLytZclBhT243a0R2?=
 =?utf-8?B?dklnbE5lY1pTNnc3eXY2ODZjN0kwT3RkRDFlM3ZzMXVBRERyVXZqeU1CbnUr?=
 =?utf-8?B?SERRWkRMR0dCRlpHQk9rTDNnOHRKdWdndmpacTdQN05yN3ZBajZsZm9jQ2pM?=
 =?utf-8?B?NGlFdnB5bmRsVXNlSVZxeVdnbk5TYmZBYWhoa1VWcUJvR3pXY0lTODdSaUhY?=
 =?utf-8?B?Q1o4Q0tGM1VSYTlMSkVHc3BHd1dPZ0VrSkQxaUROODAyamNCS3V0RkpCY05h?=
 =?utf-8?B?RzFnSjNuZHRXeE1iTnEveVhpbTBRREpRTUtEN2I0ckcyZnNqczQzcThUNlFj?=
 =?utf-8?B?WkV4OTYxRnhLbkIydHg4bGx1NHVXUGV6NHI2RTRWck4rMXhycWlSMndBUU9W?=
 =?utf-8?B?K2hrU3NOV09walhJSnRpcmNUb0FRQzE2YytSN2JZV2ZNaDluUnU1anJLcWhl?=
 =?utf-8?B?cjFxQ0xWV0VELzlJTlpRMFdRYnNRN1dDTS9LTVNwaUs1allaWlI0c1V6dGZ2?=
 =?utf-8?B?NjQ3cUJHWnlQOHc2VDRBWVlLSVVtYzlBajlvWjV6K0FBUWZYNEphbVdhZHZz?=
 =?utf-8?B?MlhhUWhYMzh3SDRmRXhNakM1a3FLN21SUDg5YjZLdSszbExSWXc3N0NUUWp2?=
 =?utf-8?B?T3hSNTdUSFN6UzBBaXg5NDJqMDh3bVRPeGlGZWlHWDUyK2RvN2tjaThRaXcw?=
 =?utf-8?B?UVlkMys4UENWell5UnU1K2h2MXltQUtpb1ZuT2ViWENIMzFBb000aUJVdVow?=
 =?utf-8?B?c05RZFFGNHZVREVIS09OZ2VYaGsySUZoYUhTcHRZbFB5V3JDMzM2dVBNbjBM?=
 =?utf-8?B?WHVRZXNMUHlGMkpUZ2pmNS95NUg4Skg2d0p5SmdGL3J0NVFFUld2ek9WdGVQ?=
 =?utf-8?B?WUprSFNJRVFMYVJuZW5xVFVFbkYwZkZwaUptMGNmbnh1Sm1sZ0JCQzdWME1D?=
 =?utf-8?B?bzU1VmFmTi9jb1NHTlFMcGJWSkVDbDFmOEpDNFFyU3lhNkMrdGFQTVE1TXVC?=
 =?utf-8?B?a0hwTVMxcGpOQjh5RW1pK2xhaXNXdXJ4YmFodUNPMHdtUW5QemhRMENselMz?=
 =?utf-8?B?a25NbDVpTERBYmQ1d2t2NVhRanZKb2FxYlN4Z1piN01kSlA0ZUYyUEpBU0NT?=
 =?utf-8?B?Y0sxeHlLeVVNTVdMdm80bVJnN3VmY1hhZ3orNkpuWVBjQ0xhMkdKUERBcmZR?=
 =?utf-8?B?bXZpZXk5dmFyZkZ4cEdKQTlFUEV5d21oK1ZKT3FFQnhESlZsZFQrcVc0TnBJ?=
 =?utf-8?B?SlFVTVFSVyt4M1g5WGF1Rm9LdlVGOXV1bDB5emlmRUlVT0tjU09zc0JTN2pT?=
 =?utf-8?B?U2cvVzF4ZGdjYTUwWjVFWW5VeTI3ZjRjWlV5eWZydnoyclEySXlYNG1VS3k2?=
 =?utf-8?B?T0phWDVZQ250KzN4ZFZNQXR5bWYrSWhhMHd5TEZxcjBtS0w5OGxuV3RxVVRR?=
 =?utf-8?Q?aXHPUCjcpCbu7kPMDJfAw20cw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1g4SlVXR2p4K3didG1jNWpnU0dmdnNjSU41SGR2WlB0SVlDcHBCT1VwUlVs?=
 =?utf-8?B?Sy9qaUkxWXZMSDJ6cno0cXZyT3g5Q2FQN2ZQZ3BFRUdKcjFqdTFsdG81VndQ?=
 =?utf-8?B?bFIxYk1yWVY4cFV5aEVOWnpqUUIveGdBNTJ1VTNUMml5VzQ1alNpZDZmS2VC?=
 =?utf-8?B?a0g4SW1DdE1QbklIZWMxaDV3MElJSFVvSTB2dk42SXhMVTFMRVhid1Z3ZWJZ?=
 =?utf-8?B?WFc0U3QrekFVQnAwcTZiYWNIMkY1OVRrRnlWazQxUzlkWVhpYVB2Z3dSOGp5?=
 =?utf-8?B?VWJhRzNmcHM3MUwrcmRjVDhJRFYrajhvV21Bb09tRzlPblZodG9Oc0xwQXhW?=
 =?utf-8?B?RSttcXdmSVVWYlhweHJpVXc3VTlmSWZoZDhuYjJvM0FZc21jRmZtenJCbmRU?=
 =?utf-8?B?SjVHQkdGazRueVN1bkdjQVUzcEdRK0NGZ054MmFEbWMrV2hUMFdkczJlSzRD?=
 =?utf-8?B?SWl1R0FkVXl3a09KaEFhU0Y3V0plMXg2VFQwZ2FXT0dneWVjSm5Fand1MTlZ?=
 =?utf-8?B?bis5K3R1dnQ4dWZEOHM3ZUdrU2xzaldSSmZ2ZU5LaWZ5VHlXYkcvcGdEWXJN?=
 =?utf-8?B?cXhwME1BT0lVa01TTDgwMmpXdklPMmgzZjVNMEUzK2c2V2ZOT0FMTnB6QlAz?=
 =?utf-8?B?NWhkT2JWYTFaaHFFblZMMUtDQ0tFOUdscHZQU2cvVVdHZFg0RzVyMVpMZmFm?=
 =?utf-8?B?anZTeTlneWs5dEd0enRCL0ZSRjJpQzhEMmRhTTVsSklCMGFSdnVuSlB3ekVP?=
 =?utf-8?B?RW5XWFFTNWpaZmNsSGFEUEkvSjBtUXdsczFJVE9nZFpTcTIxSk9vSThSTEE1?=
 =?utf-8?B?T0xSUThJRHNIeTd6UG9obTk1YzNpdC9BU09qakdlNmNFSXpaWVJ3Y0NRbjNz?=
 =?utf-8?B?WFBHcXJ5WUhWdnNJNmFtQk40b3FtbWxWTWRIYVVwZEU0QnRwamRqcldjakpV?=
 =?utf-8?B?U0NyMzlRSEF5YmE0Mjdldml6TVN0NkRneFU0RXl6a1dUUkY1SFJPTUdQZkhX?=
 =?utf-8?B?bGN6ZWE0QkFyaEE5c3hnc3A0eXlNb09uei93SCtneGRxY2F6TGdmVUpubzE4?=
 =?utf-8?B?Smt4VFNvQ3gyNHltTGlVSk1tb3QySGkybEE3dzRvTWFuSlI5b0V3ZWFiT0Jy?=
 =?utf-8?B?TGY1Sm9qTDRpeUsrbXgzdzI2aFBzZjlxRVplbmtOK2FVQUViSnlLTUtCbU9K?=
 =?utf-8?B?ZTZsWUI5MVkxekNGWVFWOGxENXdaajhqNzFKNGd0LzVMWXhONWl5cEticVZi?=
 =?utf-8?B?dENHcVZnTTZ0azQvNW1UU1FPdDkzd29UTGtpemRqWlNxbWYrcnRrU0JydXFo?=
 =?utf-8?B?SlhvZGxxSnZuL0lTOTI2TFAwSUFCM0dkeDc4d2tySlVxb0RVY0IwWG9SZDdt?=
 =?utf-8?B?SzlFeDRKUHNWUG1DMFlWZ29TMGNOajhTWlVKQVNldTA3dEkvb3dYeEljNjlI?=
 =?utf-8?B?dTdQbGNBK0FvMjBwYTlqV3phRmNOMHJQMjhwcW5YdmdFMURpUFVCZ2RsZHZX?=
 =?utf-8?B?VmwvT2dYNXR5aGFrOXA2NjBhZDRSWnBRT0c3SUEzK2lqdFZVTW5pc21mejZw?=
 =?utf-8?B?Z0l5RTVIZ2YxQ0ZkZlZKODl0VWFTeWFrSTZVQkNUK2s5SFpkYThwSU9odnhJ?=
 =?utf-8?B?ZEF6cVFCSzYwd08yRklBdDZtbTNrUG1JeDBRYjl1dWJaOTdydkZsVUJ5TVVt?=
 =?utf-8?B?VGdySG1hQUVGRWdMVlRMT0piOUhZWUF2UHo2S2liTTVhZmlqNFJnalJ1cWdt?=
 =?utf-8?B?eDNPY05XZG92ZnIrWFBZcSsvZzczZVFZSGY0TERMcXNjMEFrT3h3WklJVEtO?=
 =?utf-8?B?eWJtdmRucWRzV3pVd0laQ2Nsd1BwVXpWUW5sOHhIVkF3c3UvSUhlcXRMQW9p?=
 =?utf-8?B?bzRFR0Z4enFZeVF5SFV0MHFNd0VCTW9zcERuSHBScGxtZSszNFJYdkc1aDh5?=
 =?utf-8?B?dVl2YzBwRW1vWjVmNk9yNlRmamgrRk1wY0pCZGc0YWE5L21Xa1haM1NMZzJt?=
 =?utf-8?B?NGpUSTZVRzBMQ2UzUmM5cGR5OE5RRTlNR2ozY0U1SW8rOEhmaG15K2ZFcW9r?=
 =?utf-8?B?QUFOQk1VWGcyem9ZQjBOOEd1czVpSkpZLzdaZDlBWnVrR2oxNWM5VHBIRGN2?=
 =?utf-8?B?a3NEVklSS3hkQXo0SmZjaFlVbGpiVGxQTXhjWUZvTXZQNkVYNW9DeWY5MDBW?=
 =?utf-8?B?bEpjQnhzTHRKbUhVM29MSURxa0hWVFY0cm9MT2JRb0tsMWVqQU9UVEhkNkRn?=
 =?utf-8?B?MXNiMjRnM2hmZDNrWEYyeGI1TldOQnFCRlpObE5rbUp5Mm5sbGxzWWZCK0l4?=
 =?utf-8?B?QTlDa2pkSGZZSDJTVEFzb3Q3VVBtVldRZ2JxMmZIM3pXUDZud0NSSXdUOW9s?=
 =?utf-8?Q?kBbqhwZsRL3pqfDU=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b723ad5f-6b2d-4449-ce25-08de6282cea1
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:45:08.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoRoy+gjHEf/i+E2PnhrPC9bvDW8t2+oyUKxLFfMB8wiS1+ihBqDwHcpFO0XTh1gbocKOjIiIYbxWppzIpY7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR06MB9858

Hi,

On 02/02/2026 18:07, Greg KH wrote:
> On Sun, Feb 01, 2026 at 04:59:51PM +0000, Jonathan Cameron wrote:
>> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
>>
>>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
>>
>> are available in the Git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-7.0a
>>
>> for you to fetch changes up to 0713b26190addfa3a774b386c8658952ef9f7faf:
>>
>>   iio: magn: mmc5633: Fix Kconfig for combination of I3C as module and driver builtin (2026-02-01 16:53:35 +0000)

> 
> I got a merge conflict in drivers/iio/adc/ad9467.c and resolved it this
> way:
> 
> diff --cc drivers/iio/adc/ad9467.c
> index 2d8f8da3671d,9cfe66425d4e..000000000000
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@@ -94,8 -103,8 +103,8 @@@
>    */
>   
>   #define CHIPID_AD9434			0x6A
> - #define AD9434_DEF_OUTPUT_MODE		0x00
> + #define AD9434_DEF_OUTPUT_MODE		0x01
>  -#define AD9434_REG_VREF_MASK		0xC0
>  +#define AD9434_REG_VREF_MASK		GENMASK(4, 0)
>   
>   /*
>    * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
> 
> Hopefully I did it right?

Looks correct!

thanks,
Tomas Melin


> 
> If not, can you send a fix-up patch for me?
> 
> thanks,
> 
> greg k-h
> 

