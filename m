Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011072.outbound.protection.outlook.com [52.103.23.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9A15B971;
	Wed, 29 Jul 2026 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785283975; cv=fail; b=gduRALs+JurEHbDFq0GHVnAItc8E0IVHs168qBNvVsuMOAhsexDJm2eYSF+XJ0kKONqdzS414Avr/oqzRgF18umfUTpTxVqGmwZae2jF+Iu6Pj/1sIt9W4dPQbbOmF0ZWFYXy06ohl8S5IJ5YQjmEPKcn/VrjvRW605omYYazok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785283975; c=relaxed/simple;
	bh=rh/d1O0xl9rkP6Pw1IPkyFa5qIgnDU25Jr2+YEjTVhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhriufdC2jwLtVpj0/zGIx868jyETKWdpZ/Ju/N9n27Rze2eH1lf+o5DVNuGQgdmBisa6JYfK+3V160F6HkUvkwDBASvx3bFeAxXXVDzSx5bX5GOWD9f/Q5ZzUGkphWGl4ITU8SEtBtB/htNeY1++jIzTVbvj7VThB9zemqY0+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=qnsBqg13; arc=fail smtp.client-ip=52.103.23.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qnsBqg13"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0G1RESQvXPsg08BQuFMs4Hq2aKY5hbWY5ex7ZrgObIyvpB1pWwfgh4ooPfhjvbMAkD4/BbGPNY+3tsbyWzwvC203E7xM4RuUqszXAwtdyFb8WxHNTnBPMy+xHDmYEK352RByBTb+hyKj8T8crhuo53aVeL7zzk1hDmjjnB5C2uIpwjdP5oNVH0XBbgbxVY9w2Ma9uUC4dR902OOPn33xjO3bK4IVzo2A+3zncLP+CJTtLDtihAmKDPq3Yt/lnVIHEkoYUIu3DiQ9CIqeuYV+AO0OIlB5IE1HDnmLqAE2wUjTqCJaItmnDY7YS+xiS04/ddSMds3nyhdSng5nOyX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKLdP6UsoRg2KoVCYKOKwR5fvCcRPR2pX6Cqa1v+QVQ=;
 b=LF6omRfdiqyQLfHsd8qBIuNSsU7l5y972zSdSBRpojHkC+DFfMbI1JdBT5cQjjSlBGHvEVjyC4fMgWws06KlO8Rd0K9xROh+y4rtMDqkGYh6HCv3TBY3wh2Jibxhnjby94wHf9iUGmpZvCL1KCzu+2pM/bYYqMP1OvlkRpzQOrOm0n60NALoOHldq6CNGORcItTu1O9sdNs/fRtMafcQofFGRpNRHRiCs0dBil/SyppJSF7DmOD7NHJ5CdRgGBC/hsoBCA43evXnKLn/0aGFSdY2EIF6iaTFLE+zVLf8C8mbHzW7M96OihcV/XMrqlgk+JFuaV2WKAs781HH/RGIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKLdP6UsoRg2KoVCYKOKwR5fvCcRPR2pX6Cqa1v+QVQ=;
 b=qnsBqg13V/T6zMgQ++ihMAeOPYGlMULoA4kYzTmopqIIEl4NzsohwiXTrh5G9NvbHtAHHthN2fBYr1NB0Y4XsII+Lc6LcDzIajBvajusbI3A1zeeUc84vC9aJp4Qn3B25/3bF40BuvK+b72Qso0NTzF14iF1zvkWRxNiIQ1xeszWa+JZB/xw8GnOpyCWGw47kwyBpdx4gI+rZysIoJ9ydBKurrGV7wh/+AwD5mbBhk3PnjUUwZ61zspbe/SUc7+ez1z+Yi39C8bvyaBKWC1H/dIBqZ7ahIycQRLK9vqZa+Xzn6TOMahaLPxWsTh/zyCudNfH/TRMXYZhhxWsCecFqg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by IA0PPF9DB727AC4.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::cbd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 00:12:50 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 00:12:50 +0000
Date: Tue, 28 Jul 2026 19:12:47 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V21 0/9] Add Invensense ICM42607
Message-ID:
 <PH0PR19MB99733896FD0C3E2C24017C52AFA5CA2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260728225542.174825-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728225542.174825-1-macroalpha82@gmail.com>
X-ClientProxiedBy: DS7P220CA0051.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:224::24) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <amlFf6iUUi72oGhV@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|IA0PPF9DB727AC4:EE_
X-MS-Office365-Filtering-Correlation-Id: 443787c7-7247-4981-55c9-08deed062079
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|51005399006|41001999006|25031999004|37011999003|19110799012|23021999003|8060799015|15080799012|55001999006|24021099003|4140399003|25010399006|6090799003|5072599009|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/WNrGiYYjvTCNMmsKlB3K7ZDIEt9AuQjLwelfBQ5z8s4IAGzLVSLoAtrilj?=
 =?us-ascii?Q?sD3EcyUpXoVbKsWfTXqqO1jj90+sFA0Ot6XkuUEarfgu8V6lFuU5d/Npw+Qi?=
 =?us-ascii?Q?aIiWkMjRJ9VAQMotGH2WYE+hiLCPFQtBImPD7HP21kljeQUxNHyX2NCYyh3c?=
 =?us-ascii?Q?UaTRrTDnZ3ZclKxZjWqMUEJuiTxMD0TwEoPkHi9oJWzdV7FnPZswmcpeYSGl?=
 =?us-ascii?Q?t9Z4P3inimm0qXevZmK6/7JZm/oBSVyyb8GhPcEwKzkiNcsN9uj6IvaoDBld?=
 =?us-ascii?Q?9PA6308hUtC8u5Z4Qxpi6fbl6ZrVSfv/CHqEa9NWEgnVyzoeVzweM46R04Lz?=
 =?us-ascii?Q?VHmpFKrmsUv6LoEDbIMJb5EEx9OsAkXGkquM48WfAn2FJibGpGINUQoz/hAf?=
 =?us-ascii?Q?Dqi/0Fj8d7K624uaiDZkn58MIuY3CaecsONIFY9syPHUwnNjlI9AJ4jI8bK+?=
 =?us-ascii?Q?BI4mzooNajzs6cIwiF3tGcyeKfoC9kxnmQzUOAzoftaBI6oQvOrqZW2bakso?=
 =?us-ascii?Q?uAEzF7j6R1EzA52U3CimPcRa9xQD+HrXmhuQZCvaonkS9k68msRnkj0uSStO?=
 =?us-ascii?Q?H2s9eK6Zf5nGIRMnFmCNAEjmtWD7lhdBDsaqWlQnEsLo5rUTfqDXI7rdyB3K?=
 =?us-ascii?Q?dLAs3f3cJA9R8bMMUcxjCB06DRegc92vZs2/1pKzoULQZN/sFl1aeysudBLK?=
 =?us-ascii?Q?X/pRrDf8lH474bzahXJNfXAebJzNa6s1J/zugmpT+th9vlQ3mFpzQP+eYMWY?=
 =?us-ascii?Q?v8UhJUIqObundjpdNhXB+vOy9M815rDttrft36CjX0h0xgPPXO2ZVfkBnFqG?=
 =?us-ascii?Q?qs1tnZUUXwsMejxju4xncPyajRo91V4549lgBoxL5d7pJdrsXGy2KF8kUs2n?=
 =?us-ascii?Q?OuXU+D1l9r8Sw0eduY6k78T1pYc30DMrAQOMRcDgcHspm+DHduLBaQFC1K/w?=
 =?us-ascii?Q?E1KKw8z0EpoZrDI+6A8GXD3NB/+gQWGwKFdCSXg8lAz6ypU9w9AFPiE0lqz8?=
 =?us-ascii?Q?v3i64X98p15wqMY/jgN4pAjKOZbAccLPwpCgBeCjsO0ZHimBxrw9V5NMxtAj?=
 =?us-ascii?Q?bxpXFN0RBu9xSIxFKP4GFqzAjTfGS3E8+H5keq+CBBg1KIM3LZCilRHhlEFi?=
 =?us-ascii?Q?Eg4hfEV3doat?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/aU0YjMYAMFNK7QYOZZyuSn8bWOsDLpAndrJBqZZu4hrzASdDrTe0Oq/xPZa?=
 =?us-ascii?Q?dYV9cv0J3R4Elt3Robb41AYFE1DerfimAf5di/wxvALOdxeXVjh/rEzgi21k?=
 =?us-ascii?Q?PdWmUHSYWev9je8dSpnRMUNueF7qlFFpA40wQvP3wTRut2vRv8gtnQ2RC6X+?=
 =?us-ascii?Q?FYLo7hu4t43waJjZ30vUsK8mv53UeeYCIt94cLiQKf6EtmxUZ+LaWhpRKFRe?=
 =?us-ascii?Q?DcLUQJm+gQXfuc2H1hn0RrL6i5m7jsAmZsOPAtzRwArJkOYKU6Po/2VPlgIN?=
 =?us-ascii?Q?d63NfcjoZWAIJ1Xhd9oXw6kcO7p5QC/dMwe2RKvyHYiH+78WR4DYdXxrChe1?=
 =?us-ascii?Q?H1x2/Zje8oigVmSjZ7Ufw3MKcig7JCkoYEQjFW92bXT3RIpgQTenDyxmC3Lw?=
 =?us-ascii?Q?tQGlJ7HnDOCL614dGqIc3y1B5TMwxnDcuEK2fTVVQ8K1Ai+gxut8+BITyZ07?=
 =?us-ascii?Q?TAtTD8uHDdCiD/rwmQJIULZdOOKWOKpjXDFX3svCEaJvrlXoKCjJc6EqMYCu?=
 =?us-ascii?Q?s1MYYatdmeGaoQHAGk4kQg/oClrtiZ7U9lZ3RPXMGFFe3KIwQhU9+jXpMRe+?=
 =?us-ascii?Q?aTrDnyJp0sSCb8hwMa2klmM6hGNY6d2Y8DQpbkb3gFCHJdLPk3aoSTJWy2Pe?=
 =?us-ascii?Q?M5kSfHo31LZI0K6LZn8TfXv+AujMVG+C4rxGB3qJxMTXeyg7FGD0dLc7Afq9?=
 =?us-ascii?Q?L0wzs1ucJitJ5/l1Y4iet4QnzqivhgEE1D0UcTOfIaxHqtZX12Oa3voEvNxL?=
 =?us-ascii?Q?w+KP/Eg3JADHbroUOI56DUz8k4sRlees43r+LNCFE2M5cPeBZ9E5H63/L+f4?=
 =?us-ascii?Q?5w3FNpFSLMw3B1nmaJeZhjmPCM7+Oqu0+ierKIv0bznIzgtCxrfwLv6paPGf?=
 =?us-ascii?Q?hHWf0x7FPupDRlEZVx2hrztmXISO5RGrZR5lEcyFHNkBdgFQ3geGGEtPSSvs?=
 =?us-ascii?Q?M8eRJwxfRkMYQS/bKx4gtVKDyjq7nts64dc8zylUnL7a8+jJzEMnEmxDr1/d?=
 =?us-ascii?Q?BFwcm/IpalH+KMJkZgIIadleghr1tb2lJ1SrWnKJmwTK3UarZf8WHadNdN+a?=
 =?us-ascii?Q?KLdCBjFO7ClazOX3pKwLN8wsX9czNzFEDdYAdzE/6Ge5fO9Q1sEz08yqUf7E?=
 =?us-ascii?Q?brBs8pwZ7oBNgOowFVYbEi7GvZZ7sAOzUNsgBy9l+diXSooyjDHts4tKnC3m?=
 =?us-ascii?Q?ZpA4/2aXhqilKtF6gLMEANxHpqtLFdrM3hH8Qb9abkPi43LkltvPlogKigb0?=
 =?us-ascii?Q?dsUch2OVVu/acHH1Zdpvkz6ashJV9CyYZVmMld0ESapxRHuhZ3LRA+6Fi/bz?=
 =?us-ascii?Q?+Nk7u9AvrHr6060CCMZHnlicsyylS0Pxy05WgJpRHARuyg9CoyzSnxNF0mma?=
 =?us-ascii?Q?BN8KC21/lz24O5VeCsaoKufMlLgnaguF0i+TDd6rKfBQWsuAXlErIKlWPakj?=
 =?us-ascii?Q?t4Byek0j5EQ3A6J9Ok8uM8G0qUZcArJU?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 443787c7-7247-4981-55c9-08deed062079
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 00:12:50.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF9DB727AC4

On Tue, Jul 28, 2026 at 05:55:31PM -0500, Chris Morgan wrote:
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
> Changes Since V18:
>  - Changed driver remove function to call a new function dedicated to
>    setting sensors to "off" instead of calling PM to shutdown sensors.
>  - Corrected to add an exception so that read_raw() functions will
>    still call the accel/gyro sample frequency.
> 
> Changes Since v19:
>  - Removed remove routines and converted call to sensors_off to void,
>    and then added a devm_add_action_or_reset() to call it on device
>    teardown.
> 
> Changes Since V20:
>  - Added missing include to inv_icm42607_temp.c.
>  - Corrected note pointed out by Sashiko.dev as incorrect.
>  - Added an additional delay for poweron based on the odr value of the
>    given sensor. After doing an extensive amount of testing with low
>    odr values (and even the default value for the gyro sensor) I was
>    able to intermittently create EINVAL conditions because the driver
>    was not waiting long enough after enabling the sensor, even
>    accounting for the sleep delay. Adding a delay for the time it takes
>    for the sensor to register a value corrected this intermittent issue
>    as best I can tell. 
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
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 421 +++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 316 ++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 702 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 313 ++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  97 +++
>  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 107 +++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  99 +++
>  .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  38 +
>  14 files changed, 2164 insertions(+), 2 deletions(-)
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

Woot! Perfect sashiko score. 21st time's the charm...

Thank you,
Chris
