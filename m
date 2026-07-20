Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011038.outbound.protection.outlook.com [52.103.13.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8233CAA5F;
	Mon, 20 Jul 2026 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582250; cv=fail; b=l+S32spcB5ZJT3eXfgAwfbiIbH37vd5pSPPwvmdQOQUnMErb32ARi1ad8spq1ChO3HI1lS/k/DLFxMSIQSpIOLrpEgUKoMoh/IhBemqxgoklJnT8u3DTKW6rqZmxpHbjllggH+zN10Skscf0Ofx8P0KhGwotfcjFzxwBZGHxu8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582250; c=relaxed/simple;
	bh=bkEs+p69UvHcDjGbVEr1gIlRNdBs78hduLQRGuUvq8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QSyONaw8ebJyaH88l2MJzivBi86L17gHXerS/ATZncGGfvJ/sMdieAjABHoHwmHqQsZ3BZf0jKieLgLjIantNSpHBWuQhm4cizF8KxQnELnCxMvHoz45If60s6rxmltpHqpXfl4NvEAOKikdTN2ir3MyzBF2jSmEVjvxpDZryGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=PekvLqAZ; arc=fail smtp.client-ip=52.103.13.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PekvLqAZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhUUcEx2/l1pf76/EfbZ7S+5oCfctk8J1G3qwuFuj+0VYWZ6KobkELCVXMlwe1+UClm/h9kBYa5L3XUxoipDAlw/QVz99buuzr5tkE7LLGNMMCbHl5BZTFXKZguMxVGvzSr1aewa7/K8RETcxZR94Pmz0ttIAgPTx9vWVW6VjrdKHy9bREoXrLoaoJDVaAKN6Mddx3pxb65x0FrqJzXUKQDKXFz04JIKuMnOejgeymF2GMufRBk4gy2mk2SG155aZ2xsr+Ex6mq3TRThigEuT+Wb1aFv/zTFvzj91xtYjM3XoSLRTy6yGB8KiCn6FzDB3kUZsPnUN+Vr3NJR7FxffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz9q/sIKS71RZncXK7e1fisnJN597qxpkYc28I0y1LE=;
 b=vEnzSTPOt3aJcYeGYI17LMYr2Pf2O3KprTRwCPj0u14N2Z3xPF6qq0/lDq8JSuzA6TljQ3jsyT/mT79DR8msWS5RjOqRdO2tcvMQOgoySScl1hbQ/E3Y1Z/EzKBm8fuwFY526LiBVKc9mRYAo5p/V3TRd1np84tXSmIFUNmBo2z58u4GhpzkdQj+J18AVPjQl9QPcNg0HzgPmFaMARBx1BV9wfvHNOG/h/SqB1C7nLs1MTMyWePrJ0rTQ1G6NbkA/R3gmboKRyLJ1wJfMM6rfmyU/H4yJgpPC9GaFFCmoRYWpDpLWTkpgw8uhMWSO5QGbuRfoithDEtn7grbyJh/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz9q/sIKS71RZncXK7e1fisnJN597qxpkYc28I0y1LE=;
 b=PekvLqAZBCXiaWPIBVYvfFTmQN/2Uto5MD8/cF+tn6ABTz2xBdNoS79A1rUoQ6p5pbzSL6gPixv5JKdze/WJx0/iLwI0aMQLepi/fZAkcD4USf3sbZkebSmw9gVLPL52SrDs65AhAnnYp2ONB2AyfT8o/3S0/crJBmXscm5XMKRv77otldyCysJwS0LKZChxEPt0HzFu8VZsblsD4CkgV04CD4/8bLddzs/0HZh3ERXVZb/8ujEHWeHvwt7E/UIcc8zZ9U6+r3t6F+nTtimACe5wIPn1L9X2F3Lv7rOpN3vU/B4J3fSw9/6N9ehV8UEH7Wtz+dc7vxJTQtvvwi8QKw==
Received: from DS4PR19MB997335.namprd19.prod.outlook.com (2603:10b6:8:34a::23)
 by PH0PR19MB5623.namprd19.prod.outlook.com (2603:10b6:510:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 21:17:25 +0000
Received: from DS4PR19MB997335.namprd19.prod.outlook.com
 ([fe80::bce3:a5d7:93ac:7dc8]) by DS4PR19MB997335.namprd19.prod.outlook.com
 ([fe80::bce3:a5d7:93ac:7dc8%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 21:17:25 +0000
Date: Mon, 20 Jul 2026 16:17:23 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V18 0/9] Add Invensense ICM42607
Message-ID:
 <DS4PR19MB9973356A0303D10DFF180327F1A5C32@DS4PR19MB997335.namprd19.prod.outlook.com>
References: <20260720202343.70138-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720202343.70138-1-macroalpha82@gmail.com>
X-ClientProxiedBy: SA9PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:806:22::11) To DS4PR19MB997335.namprd19.prod.outlook.com
 (2603:10b6:8:34a::23)
X-Microsoft-Original-Message-ID: <al6QYz46opKRsmvU@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR19MB997335:EE_|PH0PR19MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d4c470-00a0-4ead-d8f6-08dee6a44b93
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25031999004|12121999013|37011999003|25010399006|4140399003|23021999003|19110799012|8060799015|24021099003|41001999006|55001999006|51005399006|6090799003|15080799012|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXJLsmP/plTzD5Xb7o28oL7FCPh+rtvKtRQuiy4JXlaAFffZG+ULU4/aRlyJ?=
 =?us-ascii?Q?BAStftajwRwC2LfgV2So/dIMObVfgO85bSDXQE0KFagI/x/zAtzSzLIfIk/6?=
 =?us-ascii?Q?HWS6TbexWaMJYrQyXbpMnyl7IQ0Be6c/lkyol53BGtpjc2Rx5TQ8pB41SLDf?=
 =?us-ascii?Q?i/7jM31QvhOdkazHiJEoTIlWocqqH6xgEucv2qv97s77UbCYtCbr2GWhvyvn?=
 =?us-ascii?Q?B5+P1GEzeiqG5M07uUv/PhPaE4JOW4X0M4Ofh59CwEq83cxz64b1MkxTAFFy?=
 =?us-ascii?Q?pIveDOC/FAV18n3bI2+t6KmkRtBYZ4jQPRfI1l9YW3uXMi7oAtNYZC+Hpc2l?=
 =?us-ascii?Q?0Z82dTdjJf1YAj22uXY0v+gUpuWCpFHuKrADTuuhmAkJBdaQpCC1Qyj5iGcN?=
 =?us-ascii?Q?WY46XHm18MVROGs9F9lOzOzieB/kCvLgJ+S9ttUOrxP7aKO+vmpBWy2N9LMp?=
 =?us-ascii?Q?SZX5rb6EI34qg3gOy8gM2H+EbaQbTJwSqR5W0Yll6t0EMeI8clz3fqMcGas2?=
 =?us-ascii?Q?VGnUqLJbAV7ynVHKJyVYf1KhzuMSWD71pMoek90f7GcD5lD2/Iao1Bn619wc?=
 =?us-ascii?Q?SFHVn/YphQivr34j0HTC7+5go211C4e5UQ/1Jj2trYWDaE7/+QhJEI/JQaQD?=
 =?us-ascii?Q?IVrnXXcEYbp2JYClWHDIL5Y/xealE69aQA0LmYz0kYKkak1Ekz/N9izEHoPj?=
 =?us-ascii?Q?4qzCxa/JIK06dOkVjFdqkGl1U2qNufOjSgSzObU92hUtbFR0+BNLaXTJIg9u?=
 =?us-ascii?Q?ZMxp/WgcChHauwuL4iB9iyK0ZPFpqMlOiefbgsMJFGMee+tqiPhfA8NmkH7N?=
 =?us-ascii?Q?1BdIUiNzVg2CBsKs6sVavYrT9u77IoVvSvI2rxo6JRj4Yf9D0BF5laBmPeeE?=
 =?us-ascii?Q?tVKMD4L4t5XbpI7x9WgyBBmxpwvyFGdssK8ydrklawuM3yDGEbYf8WZaomOe?=
 =?us-ascii?Q?d29GzmB1OQha7fbPR66jORi64fs5591P4YJlgj4S9P+vrRNUu55yMxfEw3IU?=
 =?us-ascii?Q?oSyfduR/XnIUS1LLA155ekDtlqLEepDQ4pF4EY7WIuYLCbFA5QufnnHVrgv1?=
 =?us-ascii?Q?Wsv9IZxG+Deh5SvuyywZVSMbLpNu++Jm3FdiZa2zV20rqIahqWKovYaSzm7M?=
 =?us-ascii?Q?obO8ZsgKMS47?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zgSKOwsw6NqApaJyB/anzAg/EcZSh8sb2P+p1eN+PJ78W9HXEJ81ORuYPhqz?=
 =?us-ascii?Q?STdqeCQYml2ev+Dqmw5SxD+h+ZQKA4A4vpgFrDPrFVGmmBFdWHG8+RjR4qrs?=
 =?us-ascii?Q?JKkWtea8dosrx6UC9f1l85QTYbpRb/YBXzKNoGIAfu1B3wRzGxwGfEMCkBfG?=
 =?us-ascii?Q?xdbkzkhOPUOGFkPhh+kS4zjg4fz8Bcz4D9V8Pp2z7Ama0E7Y7ZoqDhJlth7c?=
 =?us-ascii?Q?BOmIX0sgFIntpXil7VXx1kZaAMf7p7lK4mKzi88dHxcnLkTF64M8rQFPHqwp?=
 =?us-ascii?Q?marrnLvZdST5/6adzIKHzUQqv7n8gt6iDBsSDw/jnZDAUGJ0kR8trOw4xpqe?=
 =?us-ascii?Q?FwO35VhtgBulxfcDkiIXDqUahbhq5VGywKYzNh4j3BxgiS50jYb+ey/4g+iw?=
 =?us-ascii?Q?lQIUnUK669avNVh4raFgt4KZB7CMYKrGBhki0vuwo09IqP9cwfW3v9JnZ6Ec?=
 =?us-ascii?Q?Xa89nGUWMdiuDnT8dFtVEsuZPNphSmmvk49OOu7MUDueLIdaPkacyPw45VuL?=
 =?us-ascii?Q?mjiC0yEI9zbO3k5K3oqxn4udhopEb9uCdy/um5kmurcB3QiQA6XJpSZWKu5M?=
 =?us-ascii?Q?TiXhi4PR9zTsRN/Miu7laSjHwbuM/YeKV0+n+Ilirng7tVCjUF0rusDokGxc?=
 =?us-ascii?Q?+H7yszxk2peti/0NEsnm66liaHYD+Cco9MBZfjP8GEw3d+jD2kpVrxZbYJsy?=
 =?us-ascii?Q?pOrnHgSeUDjKMWTxTI66lbntK5wge3BLKEGndzWvfX0S1Reo6UuT6RhdEMk7?=
 =?us-ascii?Q?6YibvZwp3tvjUZ3Iv7xxiyaXZsq3H9BBBMxUyn3slKDaOf4v3XZrVHqy15/W?=
 =?us-ascii?Q?4SYcHoF2BR8+cBRh4P/klQ5oQy+A5cPr0SavA6nmFVgU/SyDMcpPPxFUFDGW?=
 =?us-ascii?Q?AIDUiV8yZ7djN97lZm5Mh/jHSUJWC4c7SXulQuBHqlV/ZfHAbY/21EBm56HL?=
 =?us-ascii?Q?l1e/qtI5JqzRdBckljfYThl9Ds6hlm4OE1vV67Jg3UXrFZR8muY+sXzDWaat?=
 =?us-ascii?Q?TZoxnNKWkZOBUtQ9ANmNThVZ/YJUGPE90WGREXxkDLTVMlJXUbekFk1f5jzS?=
 =?us-ascii?Q?/OP1iSxiZZwYnpdOFZfPCSuwDf1E2jPRJKSQCP9v629iwtN7C1bwNghQkBTl?=
 =?us-ascii?Q?Vxg3HTTscTFL1ExlMd5CoiQledwHW5TT6B8vVJJAmEsxrAjr7WM83hzAep5Q?=
 =?us-ascii?Q?+YOsFJbhLWHOu7yogwVHFBzb6KPuz7ANLxc29GJ77ULIgQSgmEvdSr1y5lvC?=
 =?us-ascii?Q?Arzp6n5QmeTuUs8HfY16bQpatayKDpfhIiZZigF5+J1wBlBXS6WWvJVKRMUr?=
 =?us-ascii?Q?kCvTDCV0+65dSL0uEX6+bfCuXIb/Tvf1f8sywb+1neJXrgQYiy71T2+/0boF?=
 =?us-ascii?Q?OSzLURvYcxl/+MDhyECNGH1yi2lQHX3kgTVfg1jSgaJaGftdUS8+D1JowDw0?=
 =?us-ascii?Q?Dd1fkcjfaeeQARjqulzmbbbBJveJHjdZ?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d4c470-00a0-4ead-d8f6-08dee6a44b93
X-MS-Exchange-CrossTenant-AuthSource: DS4PR19MB997335.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 21:17:25.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5623

On Mon, Jul 20, 2026 at 03:23:32PM -0500, Chris Morgan wrote:
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
> Changes Since V14:
>  - Added IIO_BE for temp sensor.
>  - Switched from ktime_get_real() to ktime_get().
> 
> Changes Since V15:
>  - Removed interrupts from required property per note from Jonathan.
>    As a result of this change I've also removed one of Krzysztof's
>    Reviewed-By tags as this change probably requires further review
>    from them.
>  - Corrected a comment about reserved values from 0-5 to 0-4.
>  - Reordered some operations so that only runtime power management
>    turns off the sensors now. This removes the "ping-pong" effect
>    when switching between the accel and gyro sensor, at the expense
>    of leaving either the accel or gyro sensor enabled until runtime
>    power management turns it off.
>  - Fixed the shared frequency value not being available for the temp
>    sensor.
> 
> Changes Since V16:
>  - Reverted devicetree changes back to removing interrupts only for
>    icm42607. Added back "Reviewed-By" tag, hope that's okay since it's
>    what was initally agreed upon.
>  - Removed PM runtime resume code, as there is currently no need to
>    resume; instead the raw read/write calls will enable sensors as
>    needed. This also allows us to remove storing the sensor state
>    prior to runtime suspend and instead we just use runtime suspend
>    to disable sensors while not being used.
>  - Additional formatting and minor fixes.
> 
> Changes Since V17:
>  - Added remove routine to ensure device is properly powered down when
>    driver removed.
>  - Corrected issue with reading scale and offset values for temp
>    sensor.
>  - Set regcache as dirty and re-sync when resuming from suspend.
>  - Added back driver data to of_device_id table for I2C driver. While
>    Uwe told me to remove this in a prior commit Jonathan requested it
>    back and it is consistent with other drivers to be there.
>  - Removed linux/mod_devicetable.h header for SPI driver.
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
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 421 ++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 312 +++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 641 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 309 +++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   | 104 +++
>  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 114 ++++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  98 +++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  38 ++
>  14 files changed, 2108 insertions(+), 2 deletions(-)
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

Still getting a Sashiko error on the PM stuff. I honestly don't know
at this point how to fix it. Is there a way to find out if the device
is already PM suspended so I can skip that part? Can I just export
the inv_icm42607_set_pwr_mgmt0() function and then use it to shut stuff
off instead of calling pm_runtime_force_suspend()?

I don't think the IIO_CHAN_INFO_SAMP_FREQ is a serious showstopper at
this point, worst case I think telling the read_raw() functions to
return to inv_icm42607_temp_read_raw() if the type is IIO_TEMP
and the mask is not IIO_CHAN_INFO_SAMP_FREQ is sufficient.

Let me know what you think on the PM stuff. Slowly losing my sanity :-p

Chris
