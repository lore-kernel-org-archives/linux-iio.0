Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012018.outbound.protection.outlook.com [52.103.11.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FE33E5ED4;
	Wed, 24 Jun 2026 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335911; cv=fail; b=evaa2Riknr0y32ZXCQMUT84RGiSRj6pMNYi45zp+2Qxp4YxYjAvw5OXYEFbYx/qHUPrAjbvF6sYvDlkkzKzT75bl20CWqe1L/wFBtLYxXwC/xvf0CFvybNpz6OJzbmDN2P6uHXRz36WBBk9nHiXTHX0/0nSsPA2pDnIW4FJaS6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335911; c=relaxed/simple;
	bh=8I1jb+34qIW3oxzSlSAeu5j3aJketBLObrG88cclUZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hBYAFzL4Dp3rW1NKKaLESIYObklGKknM3qqELfJn3tBReJuIZugUgZsp+T4WZNELKUtA03h2bJw2Tb8FyGjK741NXkNY/juwE0O0AmnQihcRUq+S1hn21/svO7YVAphy9FLAHrXZbgVjXQq3t/grkTvXJX4MlEDfDWPxSn9flgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=CtCQOKIh; arc=fail smtp.client-ip=52.103.11.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="CtCQOKIh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiNVmk9PBAannIQpyLfhlvs+L5tvAvun4I2mQTKFaQ8fYMs8BGJ3VJtPg6yF0S2bykheqra9anJOd7oHFILoE1egBbSM1hzXe9xu01sHPY92ld1Ef3rSLqiepAtram5iztgG6MfCd4QJ5VNa73glMW4YPeULFGSzTp5bu4zVLAcyDdyWDEk1agh4q7RdbLVnzQe06/ofH5Wi1pOyu94HSQN0mYP+m2nb5qkdrFWa+jZR26aJGCUJmsxYe4lt6JHmnzG4mS53Pg8bjxmW55EHmoZbXi/KQNhnKBETSpKtOmBwMASWJpDJoJ0c3V5uNQwGQBj1vf01+zeNF1LAj6NjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qFPjqJdaBKglkSJH1h1uAAZI7hIc/JXuyOA+ZnCE+s=;
 b=zNPiyJLVehXbIAAoboYDos+4XfYVVEfc5RkHW6BQl/zp/sr8VpOqyxLSbkBw+dNl7KiXgE3FJ1B6+1dThDLJegpDazY0TUe/McKJNO7RdrgNgJbPDT+SBqHI8aj/U3JsA4JNDOMd+MCxajX73TlIEZT3AjF6Enkg876FQarBs5MVxi++gEamixMbSe5p5AzM/ZDVSmYXwPkvA404hoaEaOqCvqbvB9IQWdk7pYFTJCaiqUwDXK2cANlj7h35xe67AJNDUiXX/SwhG2maHdsJ5FkLDhMl7Zoi5CMo41YWIRD9gQwa4pRUthKwYuIK/pofAhIperRIG7pmfjiWjOpeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qFPjqJdaBKglkSJH1h1uAAZI7hIc/JXuyOA+ZnCE+s=;
 b=CtCQOKIhW1cHUCfC9YWygaKaBSqlps2vu3Cj4dUVkE7ziUakoFUge/zhUlDlZSKu0tF1ZrlXy1/95RWZ+f0O0+Ov51XIlksidYzyvjN9mNPKY3IfohugrX5lvMFG/QPIxWpuTom1ahAer2QnBf7aAzUZsHgH86muLTJQ2O+7ItO3wRqat/N/G4dx1z8wrdTAIpIHXHpoLkz4wja8bPcGqKt3Hi64dyxGOA8iljDuSSmqD6wjEfGR1VEoL/46mle8e1HCvo6Aq6eCp3cFzRj3NjfqtfyKLdyElh0nCb0mttEDMf0Us7K2Um8uPylZA4Qd5IMF9JV7JfN7lY6pVdowxQ==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SA1PR19MB155709.namprd19.prod.outlook.com
 (2603:10b6:806:51f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 24 Jun
 2026 21:18:27 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 21:18:27 +0000
Date: Wed, 24 Jun 2026 16:18:23 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V14 0/9] Add Invensense ICM42607
Message-ID:
 <PH0PR19MB997338A2CC95E8E0C2670713F8A5ED2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260624182350.50467-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624182350.50467-1-macroalpha82@gmail.com>
X-ClientProxiedBy: DS1PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:8:458::6) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ajxJn32c1Z5bU0rj@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SA1PR19MB155709:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3e5239-a850-427c-96fa-08ded23621ee
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|6090799003|51005399006|24021099003|8060799015|19110799012|23021999003|15080799012|25010399006|12121999013|25031999004|37011999003|5072599009|4140399003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?48jsRd2tfzA2lWwjalttjr3JL8cx6LCyH/5oygg+l2xS8I9fRGrXERs+sH8i?=
 =?us-ascii?Q?otsjqKgd4sSGjSNSbJlZGRri84joTqrPGNvrGzLEsnN/5txakvw4i1E7Nghe?=
 =?us-ascii?Q?QiMenxoILAMls/4l3TXsM+/tG/u5aq8dxcHoBTuFDbz7Ol/SG8zZPyKnUIZb?=
 =?us-ascii?Q?SPhy7GOOynXxeWIVOTyNUFibHikYD0lZ4lPWlJfLCtDWkd+t9C46Z+0D/Dl+?=
 =?us-ascii?Q?NJMuGFBhzjDA3s3vYhT3yH1SolXWrkgRIE02wyZuNVpX0ijAgRJJVwbZSo5F?=
 =?us-ascii?Q?6QLX2McpQdjcUQ9Jkttg8ypbCxMiFUhhSrEoV0N4mN4SFFS2f+3ntr2UV6iI?=
 =?us-ascii?Q?Zt+pgmqd0awhTBlxD2qW75RAUm5VNHBRd2fsIIFN+Njd+M2Fx6wjYPJfPjNv?=
 =?us-ascii?Q?VPsjHpvl8S+m48y4rCVxLhrTRPx6ZHxUHfXgDjWRo9HuxHpf5i7LkFpgkocp?=
 =?us-ascii?Q?m67latV5GhLo2mEjAGeD5JS22juG5tiu5vnrWrs6jungeB3v73YUIcGAmRMP?=
 =?us-ascii?Q?sWcCM3e3Q17fx5f6YCy345SaOVy+xnfEXMOYj0a/HKfgi5PwyI97QLC5WIVW?=
 =?us-ascii?Q?/HVJPWK+5jCb4F/GRM7nIKiSMazHW0ayahe3x9bI2N/ItlsKJzYsPXpKdgCn?=
 =?us-ascii?Q?9W8hk9ffIns79nraVNs1/pVA11Jp7CDrcrEva8DZNlcdvlv81HbMLAcRFqhl?=
 =?us-ascii?Q?3gvqBGoC9pK11CO/FNfVomo9bROiR5qzqSRLwxCLoPkc6y4jpVITxwWz4xOm?=
 =?us-ascii?Q?uy7ioQKcHQ4DGduG/IMk/BB+wUXu9MZm5Jt2Wh2NHxnYgsWb3cNUCc+djPqp?=
 =?us-ascii?Q?Ial6SEyCLWCo2m86CO/wRCpt0kKzBhy+5ECcu2+XhwZVJi8UXkeafUiCCf8s?=
 =?us-ascii?Q?y0UZQPJm383kJTtrR46NV3cJ66SV4k6zxaWnl2ejQZ/ByaYrkCdw9dvZDcsp?=
 =?us-ascii?Q?v1Y+ZxMkuL+77W0/CwRamDKvTXA/l/08Vs/N16jjqvCRgCc3/fV907YBDPN8?=
 =?us-ascii?Q?qHs5YZ8aJ6C0U062DVDpHX7jCQ4hZcGnz61L3RMYDd7USDr0cLi8MCkCeroQ?=
 =?us-ascii?Q?j87/Q7u0yA38xUpB35swMf0mOyBXoh4ly5SuRnQwmFG9luOxByI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p89KZuLa7VwP/ySbe3VEAFkl2epDaC1GWNiFqkjj3+SArjKc7O94NomcDAKe?=
 =?us-ascii?Q?vFh8uOFs3V1kNqkIAFY5SFdCfq0j9bea7Krs8GicJ+0kjMdIpdvcxGimvJNg?=
 =?us-ascii?Q?jWVjAOtasdEd/6burcVYl/HDhQBftojMxd6jEGtSZI+yo8X9Y3G3ddf99uh/?=
 =?us-ascii?Q?Mt7fGNfDDEAbURbftUhuaIh5W7tyyFiXnybkM+qxznGzJm2Q6s5MWRAwKf3g?=
 =?us-ascii?Q?HIEGA9ia1YJL63GTqswljaKnLj+q0UU4ZQrYPhgMH2XhOqOCbbylY2dYd6nt?=
 =?us-ascii?Q?N7mLojBgxiwgNcFSUV/ZGeDmRBsIRx+U9dY+c8eu8EO937hdRaBK12iPROJr?=
 =?us-ascii?Q?VqMj8qn2loHS6ogVWGYC6UfUQwi2F4v/dr/yFhFOr/8UN41woZG9dT5NwEwE?=
 =?us-ascii?Q?SmRCZE6k1c3C4QZNhxCat48bAyiNKZRBfDeJjlLsnj2o8sXM/O04DBpfjCpY?=
 =?us-ascii?Q?YWF4lns6icAW2byEsSf7eWteZJpWdONvdeKbX89B4ZFiTV47ZNpY6Vgn4kYl?=
 =?us-ascii?Q?m0uMYgmlMgEXf2NDuVzxgEI/nYHa2avPIzliaa467E6wEP7tiXtoW5AlYGrM?=
 =?us-ascii?Q?8WHtv3e26Yjn3iBh7aOEliWMqnrqFXz7nT15WQTNt9TrjZmLGsTQfC4VzxMV?=
 =?us-ascii?Q?HDU7ZCEDv/1YWp5K1Y50jPhPH37I4hZcuNcjRrxaI81rGVM8br4fxnWsg0ia?=
 =?us-ascii?Q?b2zKPW5eKH41n+9yDWmGHlCvzIAa8Vala2vaJwR2I6cYLWPWZruJuHKY2gRe?=
 =?us-ascii?Q?rg8rt0Go6hXrn/iVt7bmv5ABC0AF1w1NV2MQRAeqcEIliM8DKOohxPaUMO+l?=
 =?us-ascii?Q?nwNgvlBSInSx4mVPBIYAIDUbW1WGUn6oZOccU24OL1ome5Q4dswL0o3I6lY2?=
 =?us-ascii?Q?ZyqcCHUP/17WlJTXHwAEEfrtDDMh2OkItqJcEag0gywc6k7IYdwjR1DpzNcJ?=
 =?us-ascii?Q?lunWjX7nuRYxqappdM+Voc6JIb+vBhrZfAvagwsjENJi/MggyxWEbcJUVD4+?=
 =?us-ascii?Q?Qz46gleOyvppBmmQWOohWDWzQQ4mZv+VKXv5oCPutvDKpAJ7/8JPAgOhvGu1?=
 =?us-ascii?Q?r592iIIiczCFG07zne5rH/TDOTLnNJjx5VFmQSHzaWKpvF/zVfOrIN3mI/FM?=
 =?us-ascii?Q?3rJevIpEVQg0Kd5bvDzwJqlZlI5nofa+7A70KRODCjEmQxee7oQ1bnhSLhGl?=
 =?us-ascii?Q?8rlqCj0t/x+OIJVsBXZuWV2zDJeKnDcvY+lPjPZAZj9jguSzulFwWTXXY3oR?=
 =?us-ascii?Q?1o/owpEy/b8mDZfh/Zm0aBHdzM9TczagnP7ULdE8DuECOLjJjFhJ8kvFSF1g?=
 =?us-ascii?Q?QuOpVt2N0zODICeLH/3LNXDdb+Z9s/3q43OORREj7HuMpe176EmYlQoYQ/2N?=
 =?us-ascii?Q?voTOungGafjAHvjdEL27wjXXa2hs4eMKrX1WFBAba5FlpqeA0A=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3e5239-a850-427c-96fa-08ded23621ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 21:18:27.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB155709

On Wed, Jun 24, 2026 at 01:23:39PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the ICM42607 IMU. This sensor shares the same
> functionality but a different register layout with the existing
> ICM42600.
> 
> This driver should work with the ICM42607 and ICM42607P over both I2C
> and SPI, however only the ICM42607P over I2C could be tested.
> 
> Changes Since V1:
>  - Instead of creating a new driver, merged with the existing inv_icm42600
>    driver. This necessitated adding some code to the existing driver to
>    permit using a different register layout for the same functionality.
>  - Split changes up a bit more to decrease the size of the individual
>    patches. Note that patch 0004 is still pretty hefty; if I need to split
>    further I may need to create some temporary stub functions.
>  - Used guard() and PM_RUNTIME_ACQUIRE_AUTOSUSPEND() on the new functions
>    per Jonathan's recommendations.
> 
> Changes Since V2:
>  - Went back to using a new driver on advice from Invensense engineer.
>  - Further split changes up into smaller chunks of functionality. Note
>    still that the largest patch is approximately 900 lines, and that while
>    the driver compiles cleanly at each commit it is not able to drive the
>    hardware until the commit that adds the Interrupt (as it also adds the
>    Makefile).
>  - Change the error to a warning when the devicetree binding does not match
>    the hardware ID.
>  - Dropped the ack on the devicetree bindings, as I am creating a new file
>    (for a new driver) instead of modifying the existing one.
> 
> Changes Since V3:
>  - Numerous small fixes (too many to list here). Thank you to everyone who
>    provided feedback.
>  - Split power management additions into an additional commit to break
>    things up further.
>  - Consolidated devicetree documentation in existing
>    invensense,icm42600.yaml file.
>  - Removed most of the FIELD_PREP from header file to c files to make code
>    easier to read.
>  - Changed scale values to 2D arrays for Gyro and Accelerometer.
>  - Removed IIO_CHAN_INFO_CALIBBIAS attribute.
> 
> Changes Since V4:
>  - Additional numerous small fixes, thank you again for all the feedback.
>  - Dropped power control API and instead run device in low noise mode.
>  - Split devicetree bindings into two distinct changes.
>  - Reordered adding of enums and structs to main header file so that they
>    are only brought in when needed.
>  - Stopped using enum for driver data and instead am using pointer to
>    device specific driver data.
> 
> Changes Since V5:
>  - Corrected use of "dev_warn_probe" to just "dev_warn".
>  - Fixed some return scenarios which would unconditionally return 0
>    when an error was present.
>  - Corrected use of max() to min() for bounds checking. max() was
>    incorrect.
>  - Fixed using "st->conf.accel.odr" in the gyroscope function. It
>    should have been "st->conf.gyro.odr" which it now is.
>  - Additional small fixes suggested by "sashiko.dev".
>  - Added a regmap cache. I used the datasheet to try and determine
>    which registers might change without explicit writes.
> 
> Changes Since V6:
>  - Corrected additional errors identified by sashiko.dev, mostly
>    fixing potential deadlocks, missing calls for pm runtime, and
>    potential overflow issues.
> 
> Changes Since V7:
>  - Dropped Wake on Movement patches, since some of the functionality
>    was only available for a device on which I cannot test.
>  - Dropped support for SPI 3-Wire mode, since it complicated the
>    bus setup (and I lack the hardware to test such features anyway).
>  - Fixed a few additional bugs identified by sashiko.dev bot.
> 
> Changes Since V8:
>  - Added back IRQ dropped accidentally when dropping wake on movement
>    patches.
>  - Dropped "Reviewed-By" tag on patch 2 because of substantial changes
>    made to devicetree binding documentation.
>  - Additional small fixes as suggested.
> 
> Changes Since V9:
>  - Removed interrupts (and buffers) from the driver. I previously was
>    unable to detect deadlocks because it turns out my IRQ was not even
>    wired correctly in my device.
>  - Updated devicetree binding commits to make interrupts optional for
>    users of the icm42607 driver.
> 
> Changes Since V10:
>  - Explicitly specified enum values in header file.
>  - Removed additional dead code for buffer handling.
>  - Cleaned up headers.
>  - Added additional locks as requested by sashiko.dev bot.
> 
> Changes Since V11:
>  - Since driver has shrunk in size considerably, moved i2c bits into
>    first code commit. This ensures that the very first commit with code
>    can now be compiled. The commit after that adds SPI support as it
>    was in the previous versions.
>  - Used pahole to optimize inv_icm42607_state. Reordering elements
>    reduced size in memory from 384 bytes to 256 bytes.
>  - Added a map of all readable registers and all writeable registers
>    according to the datasheet.
>  - Added back some missing headers pointed out by the maintainers.
>  - Added FIELD_PREP in a few more places to make the code more
>    obvious on what it's doing.
>  - Added a comment to the power management code to note that
>    temperature sensor being enabled doesn't matter as the clocks
>    are off by default when the gyro and accel channels are off.
>  - Removed iio_device_claim_direct() calls since it was no longer
>    needed.
>  - Fixed shared_by_all attributes for temperature sensor.
>  - Additional miscellanous fixes as requested.
> 
> Changes Since V12:
>  - Removed aligned buffer from inv_icm42607_state struct as we do not
>    currently have the need for it.
>  - Corrected the order of the odr values in the accel and gyro files
>    as the values were out of order (the place in the array corresponds
>    to the register value).
>  - Stopped setting the clock value depending upon the temp config. The
>    datasheet advised to keep using the default value.
>  - Corrected logic when changing between states. We only need to pause
>    when a sensor changes from off to an on state or when the gyro
>    changes from an on state to off.
>  - Added missing includes for several files.
> 
> Changes Since V13:
>  - Refactored inv_icm42607_set_accel_conf() and
>    inv_icm42607_set_gyro_conf() into a single function.
>  - Refactored inv_icm42607_accel_read_sensor() and
>    inv_icm42607_gyro_read_sensor() into a single function.
>  - Merged inv_icm42607_set_temp_conf() into initial init function
>    since it only really needs to be called once.
>  - Saved adding temp sensor for last and updated
>    inv_icm42607_temp_read() to either confirm other sensors are already
>    enabled or enable the accelerometer so it can get a reading.
>  - Updated inv_icm42607_set_pwr_mgmt0() so that it does not update the
>    sensor mode and forcibly keep the sensor enabled.
>  - Added inv_icm42607_temp_filter_bw enums since it appears to use
>    different values than the accel or gyro sensor.
>  - Set the temp startup time from 77ms to 77us, as I previously misread
>    the datasheet.
>  - Additional minor fixes.
> 
> Chris Morgan (9):
>   dt-bindings: iio: imu: icm42600: Add mount-matrix
>   dt-bindings: iio: imu: icm42600: Add icm42607
>   iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
>   iio: imu: inv_icm42607: Add SPI For icm42607
>   iio: imu: inv_icm42607: Add PM support for icm42607
>   iio: imu: inv_icm42607: Add Accelerometer for icm42607
>   iio: imu: inv_icm42607: Add Gyroscope to icm42607
>   iio: imu: inv_icm42607: Add Temp Support in icm42607
>   arm64: dts: rockchip: Add icm42607p IMU for RG-DS
> 
>  .../bindings/iio/imu/invensense,icm42600.yaml |  20 +-
>  .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |   8 +-
>  drivers/iio/imu/Kconfig                       |   1 +
>  drivers/iio/imu/Makefile                      |   1 +
>  drivers/iio/imu/inv_icm42607/Kconfig          |  30 +
>  drivers/iio/imu/inv_icm42607/Makefile         |  13 +
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 423 ++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 317 +++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 606 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 313 +++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  98 +++
>  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 108 ++++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  99 +++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  37 ++
>  14 files changed, 2072 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iio/imu/inv_icm42607/Kconfig
>  create mode 100644 drivers/iio/imu/inv_icm42607/Makefile
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> 
> -- 
> 2.43.0
> 

I got sashiko.dev's review, and agree with everything except 2 points.

1) It asks "Is it appropriate to omit the interrupts property based on
driver behavior rather than hardware wiring?" I would say no, but in
my case the hardware is not wired for an interrupt so it's moot.

2) It asks "Does this code update the software state cache for the
sensor mode?" No, it doesn't. The goal is for the device to stay
powered up for up to 2 seconds until runtime PM turns it off if it
isn't active, but I don't mind something turning around and shutting
the hardware down if it's not in use before then. Anything that needs
to read the specific sensor in question will be holding the mutex so
that there shouldn't be a risk of another thread turning stuff off
while I'm trying to use it, I don't think. What I want to avoid is
calling to turn the hardware on for a one-shot read and then
immediately turning it off once I'm done. I can wait the two seconds
for runtime PM to do it when the alternative is to call the shutdown
routine every single time for one-shot reads and wait for the startup
and in the case of the gyro shutdown times otherwise.

Thoughts?

I can fix the remaining issues it points out and resubmit.

Thank you,
Chris
