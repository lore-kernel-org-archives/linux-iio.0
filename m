Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E443FF1A2;
	Fri, 15 May 2026 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860272; cv=fail; b=ukvmi66dksUZC9b5t3/3UF7pNcZulbyylwimeI/j5byY909/1jtMU447wNciH0mYZvhL0sRNyWDoYdidmLgoEDnQNwFb9ft+LfIO1l8m+FA19cuIAD4AnBbBwmvWTWhugOUgZk9tpxQiVLMb7wf1/K4SOWTpDhroI/yRLinlMV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860272; c=relaxed/simple;
	bh=n41DC8Q4ReDLpy0A/O0S/apML0OePu9QEMxW03c4NTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PIpbPdU8yyuU6F+n5pmTKRE6KlmMWM8FIzsT3qs4sKUkrliVTHnlH8sBI4ng4iWF4p3FhFFT5MAMIIzh9X7GLJAbxu0ue8mCnqOnA/44Ugcw6eajwgsicRoGr3q45StwP/uIxAihXLgf4nG5ZA5cEUS+DkcQXvMRNSZ4H+SZz4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zWUOXCbw; arc=fail smtp.client-ip=40.93.196.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zWUOXCbw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5wQm3GDT9sIK5KKcI4FWw66tTMOIirRe6rOOuSkYQmcXPi5Av6k40PUVcJjVDwYVlNoTM5UCXhQDyPZJOVqWKbvuVu9oL/EPAHQmFqJqf5XpE8Yktz3Vw78DQQ0ApDmX19Ez/bvXwmuJQKLWLgXKip7zW3m8l/MoHax6g2aiKAxwLkPwRxKyHc25wod6+hqY3fzT506OngCcOrqwzo75ztLIvPeOa3ww9DktwlYrvMvP7JgLckGQ3RhIjn2xmZA/2/ZjaJ81JArC2pp9MdL/wnN/LLOxGkWhH+45I190QDfeqqXPndUvZNIz/ADVtzNFUiPLfSZvc2/LsS5fbeCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLTn8yOxUHmaFf0PLWhRe330eJYEyolccvbg7ARzbnk=;
 b=TswUUQMp4YaO6R1Ph+iOFoQOJwZkfRsBeLxBBZ/x8vul6YgPVTS6lN4yOvzNfmwMW2+BtrgweiiBMMwXQz/N7RxVAW+DULCzRp0cgYrLbe39Y/vO+3zqM8ToWNa3KxLyeFvUcWrIsH9yIeIbLKye70NQkOWWYPDHLZWrKjFATEwvcAk9QUQPLT+U9etBl7jGeYZ1cKRq5rll3rCOpz5ToGE5THLCa9yviuqAZSGgll5dQbp8XXi+LJgzl0kcxyRU353XaTMb79YIXLbOw6v2o+pliYo+qvPqZANtSwVrEUyrFoMrr95Hz4pbavYKnujw/qmWCIiM3nGjb1GF4HfEvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLTn8yOxUHmaFf0PLWhRe330eJYEyolccvbg7ARzbnk=;
 b=zWUOXCbwaaPukvZ46rfuhgF9NVZw1aCEt6msfq3EIUkTutNxlaZDbnXo+4zFOFU+zMvjgyPF3sW54tHIt+rO5RcROIWNYYdn6HwAq6+v3soM8rW7eCeACekASrxAUOlh99a93QvmPTkH2bN/+ZujmBUK3gL61RwwRUYveWIonFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 15:51:03 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 15:51:02 +0000
Message-ID: <1f103bf5-c9fc-480b-9470-258e63d853ad@amd.com>
Date: Fri, 15 May 2026 16:50:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iio: adc: versal-sysmon: add I2C driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com, andy@kernel.org,
 dlechner@baylibre.com, michal.simek@amd.com, conall.ogriofa@amd.com,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-4-salih.erim@amd.com>
 <afh0GW_SXuq72KwJ@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <afh0GW_SXuq72KwJ@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0681.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::15) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b15390a-ce09-4170-e02f-08deb299c449
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|3023799003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	tFN6Gl7kY9PyZXMC3pTYeOyQHD+OXju2xJ4AIGwZGnZCmNX3uLQk7B6M71ux8j4GWDlpupW+47DwXAjOWuyTfKNzGi58Xr9dW0UrLLu3HEeQ9JrNV0P1oSLvA84GA9wJpGk+lRa7x2/RM/LM4Vip0eu70Zl0hXGbua9mtNZ6/ZZYZ2o+NGYQfVvcmURt7p4nJoigiKKZXfdl+IFpJRbq7j88j2cqQvE9KBBigcCag8s1iZT6WhaMGXOuusOmZMNYjpRBTlzHFZaIog4OI8G3woHiINkjRYFOh2qh/X+FrpbmT8dc7kPSS3KExvvBXOjB4LFiKE9s6B7LTnhixdkkCodjvUYHhy2BKk+rlAon72BDdAt/0pz6t4s+wTKAA/rBlkj+KdHoicqNrrlmOPQBLc+vA/GCj1CdtUvwGIpB3+2aBylhk2LiPqaQODyshqiAK2Qq3adwB9qO7v353iIb1j/ZGx1WB2aLiDVTBIj1su2v0cD8jtsApt2bbAirPU6V5gGFxzsnb1nm/IrSAvliRcO0ucdKOAJiyQecfCpBfzdcbR85xskeLiynHlmctg0Z0n8Nf43ayMh9sna4e5PBq3PxQWfLUBeySUZUR5IiMEVl1b9iKLI3535VKQv0T7rAfyrWp5BPpLy/FFZ5EQqFr0U4GgVYiEMfaxkYrsJfQ6CLt+b6XetB3+EdI4hl6c97
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlRTMk1KdEZWOE5WRVhrdUQ3L0pkQjY5NzZDNU1mVHE3ODJ4Nko0Qm1HeWhl?=
 =?utf-8?B?OW1VdE1hQ1o0S3hKektTQXVpRWo0WTdlUTBmWDN6QXlBWis4emhtSTlscmhi?=
 =?utf-8?B?Z2FvSDFqVENIUVRvRmYyaWN1VW9lM1d1WTNES3pyYU03UXVCTHhXaVJvTVY2?=
 =?utf-8?B?M0V5SmhWM25acGNta2s3RitsMTRuMVhDODBNRmJwdHkzRXE0WVVpTm9yc1gx?=
 =?utf-8?B?Ty9odnhmRmNUR0R3NkRoVFQ2ZFBnVUpyTktHUkFud0ZFZCsvaTg4K05GZWJl?=
 =?utf-8?B?eTB5SUpPNkUwanNyaDNDVHRMdVZWMzBQNUF2VVdueG9GRWw5bXJjNnVmM1Ex?=
 =?utf-8?B?YVJkUHg5ZjhDNXcxVTFBTmVNTWwza1NLYnhYYi80Uy9HdGx0ZnhRMjNkemxG?=
 =?utf-8?B?TTd3dFI3MHhjTFNjTld4eEdLdGlCN1czdUk1TStKem94L29HdjdzYW16d1JD?=
 =?utf-8?B?M1JBWEFRMkJMSEp3bzVMb2dYRzRjQUk5VXRwYkx0b2tVRHNZdi9MSDhyRTdW?=
 =?utf-8?B?Vkw2Q0NMaEJ0bHhTUDRaaFVGSCt4V0hCdk9ibG56WmRQaDI0STBYcnBUeCtx?=
 =?utf-8?B?VW45Y0pudXUvRWtTUzNMOUFhVzR5Sndud3JHQ291eXRHRytwQUxXWnhmUita?=
 =?utf-8?B?WXNJbHBacXlGc053TjFYZWVpV3VLYlFzMElmdTNXb3laZmROMlFUNnFtREZ2?=
 =?utf-8?B?cThCQXhSSW9yZmxnckhiV0Jzc25yTm5tUkRJK1dnN3ZyOHVNVlZOWkpqSHkr?=
 =?utf-8?B?TGVYMU9rdTVhTTBzUmhDeGNLa0poazF4T0VRb3Rzb0U1OTlDNFVQc2tFM1hO?=
 =?utf-8?B?ZmROMnVaTklxZ3dsYnh4alF6Yk1FdkFnb2VCbXBoUjVvamVKR3VxM1FoRWJy?=
 =?utf-8?B?V3FMU3lBVS9VWjhseThyZlQzYzg2ZWRiMFlUUjVoTkd4blVWLzYyUmM4eU14?=
 =?utf-8?B?cVVRRUFzVi84V0JrSE53dG1CQkFzajY4cCtLZW9DUnByUmRVWnBoOW5OYk14?=
 =?utf-8?B?Q1Q1L2dzaXBYWHE3NGppbnlXeHF4cUZiWmM3dVUwcUMvZHZ0NWl2ZnRuZ0pG?=
 =?utf-8?B?TWZtaWN1UXdRcVVzWmhwazJVam9Zd2xObkY4YlBRTkpaWlFoYjZXWnFvTzI0?=
 =?utf-8?B?bWdod0RTSkpSM0RtMTVUL0MxU0wxRFYxVVNMMzlzSHFubndBT0FuQXlrMG4y?=
 =?utf-8?B?R0U1TDlINXVpMEFxZW5wangxb2JtVXhtK0V2NTNuY2tYKzBjYmRKREwwL2h4?=
 =?utf-8?B?dVd4L0V6R2FxdkY3TFNMbUNRekFBL3ZkMEI2S29HT1AzTVFyWDdwazlJeVN3?=
 =?utf-8?B?UXhxTGV2aGNWa3hWcXg4RnRYVkRCVm1LTlk1ZGQzaitzWEZON29GWjY2R0JR?=
 =?utf-8?B?TTg5dUJNcWRMZVQzZ1M3Qm81T0QvQmdLTG1Dc0F1NWVaZ212YXN0L011ZExo?=
 =?utf-8?B?TVV0QU1hSDZlTHRteWJEdzZrYVBnNXE5ek11UXBabWkrOHVIcEtrZG9raVRT?=
 =?utf-8?B?V1FCdlVMb3NsOE11dWEzZDlYKzdPYmxRc0lYVllLalJ0S2xROE1iRjFOcWpU?=
 =?utf-8?B?RFNibzFKcWhyd3BhNEJyaDFKczVBNWJ3QUcxVlQ4d3VnK3cybE5qcHpGY2Vx?=
 =?utf-8?B?dW0vaERVZ0ZMSGpoeXE0cElCTTF1bjdiSnFOeVgzRVBoWU9UOHJXbDkvRnBX?=
 =?utf-8?B?dVNTQUZxd3VwaFhYeFlBRGdxZmR2WEViWTZsUkkvYVU4UFZEbFd1QVcrS3p5?=
 =?utf-8?B?M20yd1E2eXQ5L09BeHNmcWQ3VjQ4WkJwQXBjTTk5dzJlODFGM2tUa0d4MFBz?=
 =?utf-8?B?Ky9wUlVyb0poS1ZuU3QrNUxHYStvQlYzSHRBNk8yUkREYlA5M3UyME5LT0ds?=
 =?utf-8?B?TENvaCtOQUg1NjFPRUp5QjhqcHBMN0hIb1lVRXpOMDlsNTlpaDBCVWREaFQz?=
 =?utf-8?B?VmlpbnhlME42R2ZBSW05cU43VUVJTWdIY1dGR2Q4S21EYy9hbEdhcmFTR0p3?=
 =?utf-8?B?VUd6OGV3NGxiZUxwOGliYjgxSEtyT0NORGFBQXBwZmtiaE42a1FPamhWVXBF?=
 =?utf-8?B?OEV6cXJNZ2h5TENKQk9lS1llVkZlTXYyMTRzVytTYlI4OVMyMUZNREhWOGlY?=
 =?utf-8?B?bVBndC9WejdDd3VEYUR0U0dWUzJtdG9hN2VSVjVGOEZqYVQvT0hiZTMzWkZT?=
 =?utf-8?B?MVd4ZFVMejRyd3FRbVVrYng4ZDVRakJsVzZjUEJTUmI1YjNmOXh4dHNjR1E3?=
 =?utf-8?B?R3l4TlN0Q1lRYTlyNThVZjZrVllteDFMWEVXRksvZ0FOSzNlQlArS3F0aDUy?=
 =?utf-8?Q?DXfUoMEWqZortHwykL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b15390a-ce09-4170-e02f-08deb299c449
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 15:51:02.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWT7JDHlsF814bR997BOpX9CIM1/eY4F2TUKDkUC6xkVYrZHs+VCj5wn6HLZH+fN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473

Hi Andy,

Replies are inline.

On 04/05/2026 11:25, Andy Shevchenko wrote:

>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
> 
> Follow IWYU.

Accepted. Will audit and add missing includes.

> 
> ...
> 
>> +enum sysmon_i2c_payload_idx {
>> +     SYSMON_I2C_DATA0_IDX = 0,
> 
> Is it mapped to HW bits or is it pure Linux enum? If the former, assign *all*
> items as per datasheet, otherwise drop explicit assignment (it's rare that we
> need it in the software).

These are byte offsets in the I2C payload buffer, mapped to the
hardware protocol. Will assign all items explicitly.

> 
>> +     SYSMON_I2C_DATA1_IDX,
>> +     SYSMON_I2C_DATA2_IDX,
>> +     SYSMON_I2C_DATA3_IDX,
>> +     SYSMON_I2C_OFS_LOW_IDX,
>> +     SYSMON_I2C_OFS_HIGH_IDX,
>> +     SYSMON_I2C_INSTR_IDX,
>> +};
> 
> ...
> 
>> +struct sysmon_i2c {
>> +     struct i2c_client *client;
>> +};
> 
> Can't be the struct i2c_client used directly? (Haven't checked if this is going
> to be extended or have special uses.

Yes, the struct only wraps the client pointer and is not extended
in later patches. Will remove the wrapper and pass struct i2c_client
directly as the regmap context.

> 
> ...
> 
>> +static int sysmon_i2c_reg_read(void *context, unsigned int reg,
>> +                            unsigned int *val)
>> +{
>> +     u8 write_buf[SYSMON_I2C_WRITE_SIZE] = { 0 };
>> +     u8 read_buf[SYSMON_I2C_READ_SIZE];
>> +     struct sysmon_i2c *priv = context;
>> +     int ret;
>> +
>> +     write_buf[SYSMON_I2C_OFS_LOW_IDX] =
>> +             FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
>> +     write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
>> +             FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);
>> +     write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_READ;
>> +
>> +     ret = i2c_master_send(priv->client, write_buf, SYSMON_I2C_WRITE_SIZE);
> 
> sizeof()
> 
>> +     if (ret < 0)
>> +             return ret;
>> +     if (ret != SYSMON_I2C_WRITE_SIZE)
> 
> sizeof()
> 
>> +             return -EIO;
>> +
>> +     ret = i2c_master_recv(priv->client, read_buf, SYSMON_I2C_READ_SIZE);
> 
> sizeof()
> 
>> +     if (ret < 0)
>> +             return ret;
>> +     if (ret != SYSMON_I2C_READ_SIZE)
> 
> sizeof()
> 
> With them the code will have one source of length an be robust to the changes
> of the buffer sizes.

Accepted. Will use sizeof(write_buf) and sizeof(read_buf) throughout
instead of the defines.

> 
>> +             return -EIO;
>> +
>> +     *val = FIELD_PREP(SYSMON_I2C_DATA0_MASK,
>> +                       read_buf[SYSMON_I2C_DATA0_IDX]) |
>> +            FIELD_PREP(SYSMON_I2C_DATA1_MASK,
>> +                       read_buf[SYSMON_I2C_DATA1_IDX]) |
>> +            FIELD_PREP(SYSMON_I2C_DATA2_MASK,
>> +                       read_buf[SYSMON_I2C_DATA2_IDX]) |
>> +            FIELD_PREP(SYSMON_I2C_DATA3_MASK,
>> +                       read_buf[SYSMON_I2C_DATA3_IDX]);
>> +
>> +     return 0;
>> +}
> 
> ...
> 
>> +static int sysmon_i2c_reg_write(void *context, unsigned int reg,
>> +                             unsigned int val)
>> +{
>> +     u8 write_buf[SYSMON_I2C_WRITE_SIZE] = { 0 };
> 
> '0' is redundant.

Accepted. Will use = { } instead.

> 
>> +     struct sysmon_i2c *priv = context;
>> +     int ret;
>> +
>> +     write_buf[SYSMON_I2C_DATA0_IDX] =
>> +             FIELD_GET(SYSMON_I2C_DATA0_MASK, val);
>> +     write_buf[SYSMON_I2C_DATA1_IDX] =
>> +             FIELD_GET(SYSMON_I2C_DATA1_MASK, val);
>> +     write_buf[SYSMON_I2C_DATA2_IDX] =
>> +             FIELD_GET(SYSMON_I2C_DATA2_MASK, val);
>> +     write_buf[SYSMON_I2C_DATA3_IDX] =
>> +             FIELD_GET(SYSMON_I2C_DATA3_MASK, val);
>> +     write_buf[SYSMON_I2C_OFS_LOW_IDX] =
>> +             FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
>> +     write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
>> +             FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);
>> +     write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_WRITE;
> 
>> +     ret = i2c_master_send(priv->client, write_buf, SYSMON_I2C_WRITE_SIZE);
>> +     if (ret < 0)
>> +             return ret;
>> +     if (ret != SYSMON_I2C_WRITE_SIZE)
>> +             return -EIO;
> 
> sizeof() in both cases.
> 
>> +     return 0;
>> +}
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

All items will be addressed in v3.

Salih

