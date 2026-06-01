Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011031.outbound.protection.outlook.com [52.103.14.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98563AE1B1;
	Mon,  1 Jun 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321808; cv=fail; b=aNaW0Os+7pEHTSSTg27x7yNgteakhsMDvxZ1P6G8nvTAxEOM0uJO9NAULBmEBxuo0BTXa+0wj9ucbTYJo2/+p/uy1+0YONkFVeDPAbHeh1Bl+/C9grFJh4iNmexdC64hvx5g21YNp0UBOT9kLu6BKjgly8uY8qWTE0bJaE7stJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321808; c=relaxed/simple;
	bh=NpAEB+Snjq7Q4O6sy5V3Pwge/ThMotgbnl8YAERv+vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V7nIy/5tH0lbWbBO8WNZWUPOY+NLfUewWk33GpZorD3pOFNxjcdAEmDKZJvtBsYpseNXLoFWvEGVi33GxLlbwSnpOW9ISclEuZtGjOok5p9hFKn1kwLFxmN58MZ1YvrMlSP5k1fBOooSAw1j99UKAo9eFe3U7IVPrYHd+W+D9gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ng26Ejrk; arc=fail smtp.client-ip=52.103.14.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ng26Ejrk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqD/9jvYvc9EinAWmLjI581Y60/7wpZgkNCYQ0RI/OnKxVdcsrAE3l26q8IOYd48h+B3xRAWN4vKBsMB6rycCgNkNLvgytZZTp4DgM24VFVQAsElUr5wJhIFqZ4goDcEkMsCoy68v1bVd0j7OM+lLf4mDfRmGYbd7dWETxmg+7rFx+/KWfICU4MuHHRUyKYVm4C/D8zgbrv0dJheB0Q3byEEs38hQde0CDvdqeaWHbzhgFbJPtrWulRwzHovJ40FvWE5q4wlneibJLEjmQOejR488AncwFOzCpQyxoRQ6yPCwyrzq3BM1jcl2LUC4VCxNlTqWkKXf/pMm02nGVmyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCQb+3dAX2TecpczA0NmrFhjq6SZ7T+kWfJZKUsQp8c=;
 b=G/MpPaJxI1DT6ZF6J1BpazAbpR93HjH8MVBY3tJwz1hMWwCOpGb4weUCQ0FNpU+BgOE8lkghHKdLDaDhcdH9Ktqtz5GnZLy5Th0yUPAyNioDjcuqf/RmO7dZ+s6yKGRnpHWfaoDjG+yJuXJo/Uz/eZ5+F19wr1HopCGbD5FGkagW657DuzXt9HEUpkh+g0gpgfK/1gKNvSMQteHR42x++I6ZTr7bkZuxWbNq+kN7JqCFq5zfpjvbRw16tNXnPhUAB95L/CLrBb6V56QqVhH2WRpNmHt8s1ZIXWntmqejrDGSQKo2Ws2CvRuBEQzmB2Boo1lFabQYhCwQSlNlmxWazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCQb+3dAX2TecpczA0NmrFhjq6SZ7T+kWfJZKUsQp8c=;
 b=ng26EjrkWDph3of/Clvl3B8dDvCuu5mFSoSojCD4lwtxFOSAajvPrf/pbxOW0VZkVOhwmm/EZqxWr7JJBhT/+12PCgq4/+snTvbixAAP5GveckSxLNFTSKdSNTmLl60JX2OLOzl7H9j4t0u5UU09Uqj0I6KMDE/Bb9Yexd6rPoYKXNPZi44TyysT0V7cxtCsvts/Rp+xQyaVIMtm3T5r/msBnbpm/GWVZ2eyDnpF0jyF24lbwDdJbTuUozx45UKPSWXOa7oUXfMJ22BKUSnDSdcxLis/NXu3vHRVLxcM12jhxZ0rifE7lmES2k8OzQg9pnMriWyDxsDF2GIYwSTDXQ==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by LV8PR19MB8599.namprd19.prod.outlook.com
 (2603:10b6:408:265::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 13:50:02 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 13:50:02 +0000
Date: Mon, 1 Jun 2026 08:50:02 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V9 06/11] iio: imu: inv_icm42607: Add Buffer support for
 icm42607
Message-ID:
 <PH0PR19MB997338785108348427BBB2B7D2A5152@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
 <20260530031739.109063-7-macroalpha82@gmail.com>
 <20260531133801.481e173c@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531133801.481e173c@jic23-huawei>
X-ClientProxiedBy: SA9PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:806:22::34) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <ah2OCmoeN8qLXX4o@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|LV8PR19MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4983d8-1088-432f-354f-08debfe4ad9f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|25031999004|37011999003|5072599009|6090799003|51005399006|12121999013|41001999006|23021999003|8060799015|19110799012|15080799012|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CsuXU0MnIRBVPfPATJK5cL7WrnX+Pz9qs6u0zA1F2J2+1HeYinMap2xecFUr?=
 =?us-ascii?Q?XWjGurFWMESgFWo1FmQTB5sDnVEuFfiXyKtrWPPVNayBM0E/vpnlenyUO/La?=
 =?us-ascii?Q?2h6Mruyxm5oiRctOTNTytYOl5hrypfPShUxDZi3H861D4CIfZmxBZYwznr+v?=
 =?us-ascii?Q?Qig+Y0ZeLjAXdDT/USPwhGZry595vBL1CrD2p5j0Ga0gZ258w1FUdymoW2s3?=
 =?us-ascii?Q?19wR/kurpM4wKvznEn2q1UKQ2Mi9OxpI0cwTWBxYfGv68U1Li/YUmjFfVbGE?=
 =?us-ascii?Q?EdH9lTGuUMMg1bdgEafXHrxYLVjejMZJ5wJyutR7g3pY8SO3AzjGXFL1w3If?=
 =?us-ascii?Q?Ot6MvwQLp8iwSYI+JePwSR9FxY+AbIYUne4yQ46DTiJVd+cA3ayDbOm4c+fS?=
 =?us-ascii?Q?JihmoO8PWpAs9ZhdsRxdzHJLcjW37y+POfUASw3Kc/RWYyU/b7iTp0VL6k0w?=
 =?us-ascii?Q?xbQQSQXLVma/C8ZAg0OgnHwQkEEvaIsxdJdgAB1Hro3+aRN6XG2iHGwiTqcz?=
 =?us-ascii?Q?zSeAmzdFuCg1UDOi4hATIjgBhrAMUCWyoHSfu+gVkdtLOHJZ1/GJrQDOknQD?=
 =?us-ascii?Q?lAJ0be3Kev1NEZ/HCqeTm2bBlVXCGqHQuwpG3K+Dk3gAwg8IjbgKq8BWakpR?=
 =?us-ascii?Q?Ga2F8tLVc/D8IH5gdzB6EL9yUC1yQk96rCWrSL/ma9ppJb756t33Bau+pC5a?=
 =?us-ascii?Q?EmLw7z+0jZkE589jJ2+adp7R2JRafx70QKl8N5gIg3sR61NH3H/3Dmhc0tVE?=
 =?us-ascii?Q?DoMOAxpYGS2gFwGHCxObEa0gkzpjG0P74tH/CI99KCS2Ccqdk1q9FGetTkPB?=
 =?us-ascii?Q?FNC/l1Ahj1a6kg3oW13HeKnj6/TGg4Mhv6zi8vzmKvOyO8sPIoHENeVOlvXa?=
 =?us-ascii?Q?4Bv4QVaIO729gBsBSYCfeunU8yPKHUvQYXPXXXT7CZhalHHvQJvf2yXRDAPn?=
 =?us-ascii?Q?kc7kCOiNvyAFPQNj6I6Kdg+sqLK2apSiGKHjXjgeZ5WF2Xw1AbyM1+pdmHcD?=
 =?us-ascii?Q?yRUYGh2+anTs7OyM9cFP/8LE9zVN39TIvFaLgxbdGysrbX/nYCQnrjVf/Ang?=
 =?us-ascii?Q?pbcxVbbCgQNjTbe4J25eTL3/umshPQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jkj1fsghCJu88wNi7fi3PlTXfKu7X1LV/onki/d6hef/rv6DUeJaxnSj7XbX?=
 =?us-ascii?Q?D+BHBth+WO0eFbFnuclnVPYt0YTbrv16saY6UGirWWR+7T6q5nf2I5BqkZOi?=
 =?us-ascii?Q?VciY1lJc+GBFjnhEtjiIpE9FMyce1+47imMvnYjcr9W3qOJ7rUWDGHzQV4LO?=
 =?us-ascii?Q?rbp61Z4OO2fCLWSLggGKkMcIY5bSNCPeRUy2NZWmzR8SBjjqf6Zm2jeXlcPl?=
 =?us-ascii?Q?BuPSf+XQxneZenyvombbGZTQ777Wu48GsUSoWZhrYM+44iaFGTAWl53+VCmm?=
 =?us-ascii?Q?h5Vu3kA2grcDArR7rmnpoA7hRFreXSQUyj3+EurPi7azurkql9cKCgbqVT8l?=
 =?us-ascii?Q?3sxYhEI02986fg1KAanwmZul40Sipo8ScQdiPCDGDmsi9bWOz8YWDZc88dr+?=
 =?us-ascii?Q?0gjNs4sPe5ecALvTmUgZ1+20hfQdUFGN5JCHjrQQE1A7mkWcgAl14p4UfJnQ?=
 =?us-ascii?Q?kShYvLQk4faAEpQJtKH6FGKWNLEwuekV0aiOm40vXJ4q4tZi19pYFCZZ+xvp?=
 =?us-ascii?Q?zN0Zu0wmXoRGZPvmIL+g8fEF/d9rtZiLAPOstoeYTvNqZLQ76VVPNkJ5wLZo?=
 =?us-ascii?Q?jnQ+F0JP4qMPZXrrhdN/5+GlwmugXRfY9fMryhDQCA7FhEa+m3o3wClNuYZH?=
 =?us-ascii?Q?Ewz6/Le8ihrKR7GWJDupYTog/zboMnjoQBGZ5JrMU+GXVYWId1GS40U7V9X0?=
 =?us-ascii?Q?TMsVZ9Luk9VY1F90ZtHMWYPFH9f0kk7i8mHCTvmpRDs0+LhzFfwOiVcPGJUo?=
 =?us-ascii?Q?YVslDhnWOmOtY+9eeyW7OQXwbrOBrd86nZI27kbVK1Ii6JrvNmw8qcndwBFs?=
 =?us-ascii?Q?ASkL9i+059t20TKC8i+n0S4J939T1Qp2TzT6XnEGshW+n0of/zcvEfeNiwc1?=
 =?us-ascii?Q?cm4tP8nhB9+gusfnsM5V7of1xPFBV4lSJQhGFKIISIjOo0AFrRc+q6ay/U6O?=
 =?us-ascii?Q?DXlbKNV6uBIddu4bg5boiRutQHOghwc+WaDFizAVFoOBLExnXHd2iqoCA6tQ?=
 =?us-ascii?Q?eQBhYL/lIkKj8EpdbbOKr3eggprTwT/6P4heAIoAjTEiKkTGxikqW0R6TQCO?=
 =?us-ascii?Q?lhLiH54bRNFigNvqOqlQxRzm7BapZEqGulNCFz8jnyz3GCKx5VQ5BGSBpaTG?=
 =?us-ascii?Q?zpKWbDaoe3fgfBnF+7dACEa25ztthrSR1QFPpassbhXfoYf53KwdUNg+2VIN?=
 =?us-ascii?Q?L4yWyhIiE+0Ij9Cr94b9s11202drlcqzCkfDN6iQTsnhc8XE7yw0CL97Xqi9?=
 =?us-ascii?Q?zGX80rQyrulLa4PEzIny44PxjWvGp03lQXGlOg/R2jZrjZygdQEK+oZOKPfe?=
 =?us-ascii?Q?+Lh1kNCKeFVr95RZQln+0eLo6tPw1P0pCrVZGBXDfktNQUteO/dh3mnCagVE?=
 =?us-ascii?Q?mhUAtfcAeZja+4rJQOPHEWAkhf3hfNhqvyczNthmGX8dds4Z8g=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4983d8-1088-432f-354f-08debfe4ad9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:50:02.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8599

On Sun, May 31, 2026 at 01:38:01PM +0100, Jonathan Cameron wrote:
> On Fri, 29 May 2026 22:17:33 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add all FIFO parsing and reading functions to support
> > inv_icm42607 hardware.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> A few things inline.
> 
> J
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> > new file mode 100644
> > index 000000000000..e065d60ac119
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
> > @@ -0,0 +1,483 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2026 InvenSense, Inc.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/minmax.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/unaligned.h>
> > +
> > +#include <linux/iio/common/inv_sensors_timestamp.h>
> > +
> > +#include "inv_icm42607.h"
> > +#include "inv_icm42607_buffer.h"
> > +
> > +/* FIFO header: 1 byte */
> > +#define INV_ICM42607_FIFO_HEADER_MSG		BIT(7)
> > +#define INV_ICM42607_FIFO_HEADER_ACCEL		BIT(6)
> > +#define INV_ICM42607_FIFO_HEADER_GYRO		BIT(5)
> > +#define INV_ICM42607_FIFO_HEADER_TMST_FSYNC	GENMASK(3, 2)
> > +#define INV_ICM42607_FIFO_HEADER_ODR_ACCEL	BIT(1)
> > +#define INV_ICM42607_FIFO_HEADER_ODR_GYRO	BIT(0)
> > +
> > +struct inv_icm42607_fifo_1sensor_packet {
> > +	u8 header;
> > +	struct inv_icm42607_fifo_sensor_data data;
> > +	s8 temp;
> > +} __packed;
> > +
> > +struct inv_icm42607_fifo_2sensors_packet {
> > +	u8 header;
> > +	struct inv_icm42607_fifo_sensor_data accel;
> Good example of the need for the inner structures to be packed

Are you saying I should set the inv_icm42607_fifo_sensor_data to be
__packed? I think I was told in a previous patch not to do that, but
I can add it back.

> 
> > +	struct inv_icm42607_fifo_sensor_data gyro;
> > +	s8 temp;
> > +	__be16 timestamp;
> > +} __packed;
> > +
> > +ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
> > +					const void **gyro, const int8_t **temp,
> > +					const void **timestamp)
> > +{
> > +	const struct inv_icm42607_fifo_1sensor_packet *pack1 = get_unaligned(&packet);
> > +	const struct inv_icm42607_fifo_2sensors_packet *pack2 = get_unaligned(&packet);
> 
> Hmm. Sashiko points out you are messing around with pointers here and it's not those but
> what the point to that we need to worry about alignment for.
> You could memcpy that data into local structures.

I still suck at pointers, sorry. What exactly would you recommend here?
memcpy the packet value into an allocated
inv_icm42607_fifo_1sensor_packet or inv_icm42607_fifo_2sensors_packet?

> 
> 
> > +	u8 header = *((const u8 *)packet);
> > +
> > +	/* FIFO empty */
> > +	if (header & INV_ICM42607_FIFO_HEADER_MSG) {
> > +		*accel = NULL;
> > +		*gyro = NULL;
> > +		*temp = NULL;
> > +		*timestamp = NULL;
> > +		return 0;
> > +	}
> > +
> > +	/* accel + gyro */
> > +	if ((header & INV_ICM42607_FIFO_HEADER_ACCEL) &&
> > +	    (header & INV_ICM42607_FIFO_HEADER_GYRO)) {
> > +		*accel = &pack2->accel;
> > +		*gyro = &pack2->gyro;
> > +		*temp = &pack2->temp;
> > +		*timestamp = &pack2->timestamp;
> > +		return INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE;
> > +	}
> > +
> > +	/* accel only */
> > +	if (header & INV_ICM42607_FIFO_HEADER_ACCEL) {
> > +		*accel = &pack1->data;
> > +		*gyro = NULL;
> > +		*temp = &pack1->temp;
> > +		*timestamp = NULL;
> > +		return INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
> > +	}
> > +
> > +	/* gyro only */
> > +	if (header & INV_ICM42607_FIFO_HEADER_GYRO) {
> > +		*accel = NULL;
> > +		*gyro = &pack1->data;
> > +		*temp = &pack1->temp;
> > +		*timestamp = NULL;
> > +		return INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE;
> > +	}
> > +
> > +	/* invalid packet if here */
> > +	return -EINVAL;
> > +}
> 
> > +/**
> > + * inv_icm42607_buffer_update_watermark - update watermark FIFO threshold
> > + * @st:	driver internal state
> > + *
> > + * Returns 0 on success, a negative error code otherwise.
> > + */
> > +int inv_icm42607_buffer_update_watermark(struct inv_icm42607_state *st)
> > +{
> > +	const struct device *dev = regmap_get_device(st->map);
> > +	unsigned int wm_gyro, wm_accel, watermark;
> > +	u32 latency_gyro, latency_accel, latency;
> > +	u32 period_gyro, period_accel;
> > +	size_t packet_size, wm_size;
> > +	__le16 raw_wm;
> > +	bool restore;
> > +	int ret;
> > +
> > +	packet_size = inv_icm42607_get_packet_size(st->fifo.en);
> > +
> > +	/* compute sensors latency, depending on sensor watermark and odr */
> > +	wm_gyro = inv_icm42607_wm_truncate(st->fifo.watermark.gyro, packet_size);
> > +	wm_accel = inv_icm42607_wm_truncate(st->fifo.watermark.accel, packet_size);
> > +	/* use us for odr to avoid overflow using 32 bits values */
> > +	period_gyro = inv_icm42607_odr_to_period(st->conf.gyro.odr) / 1000UL;
> > +	period_accel = inv_icm42607_odr_to_period(st->conf.accel.odr) / 1000UL;
> > +	latency_gyro = period_gyro * wm_gyro;
> > +	latency_accel = period_accel * wm_accel;
> > +
> > +	/* 0 value for watermark means that the sensor is turned off */
> > +	if (wm_gyro == 0 && wm_accel == 0)
> > +		return 0;
> > +
> > +	if (latency_gyro == 0) {
> > +		watermark = wm_accel;
> > +		st->fifo.watermark.eff_accel = wm_accel;
> > +	} else if (latency_accel == 0) {
> > +		watermark = wm_gyro;
> > +		st->fifo.watermark.eff_gyro = wm_gyro;
> > +	} else {
> > +		/* compute the smallest latency that is a multiple of both */
> > +		if (latency_gyro <= latency_accel)
> > +			latency = latency_gyro - (latency_accel % latency_gyro);
> > +		else
> > +			latency = latency_accel - (latency_gyro % latency_accel);
> > +		/* all this works because periods are multiple of each others */
> > +		watermark = latency / min(period_gyro, period_accel);
> > +		watermark = max(watermark, 1);
> > +		/* update effective watermark */
> > +		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
> > +		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);
> > +	}
> > +
> > +	/* changing FIFO watermark requires to turn off watermark interrupt */
> > +	ret = regmap_update_bits_check(st->map, INV_ICM42607_REG_INT_SOURCE0,
> > +				       INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> > +				       0, &restore);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* compute watermark value in bytes */
> > +	wm_size = watermark * packet_size;
> > +	raw_wm = INV_ICM42607_FIFO_WATERMARK_VAL(wm_size);
> > +	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
> > +	ret = regmap_bulk_write(st->map, INV_ICM42607_REG_FIFO_CONFIG2,
> > +				st->buffer, sizeof(raw_wm));
> > +	if (ret) {
> > +		dev_err(dev, "Unable to change watermark value: %d\n", ret);
> > +		if (restore)
> > +			regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> > +					   INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> > +					   INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
> 
> set_bits.
> 
> > +		return ret;
> > +	}
> > +
> > +	/* restore watermark interrupt */
> > +	if (restore) {
> > +		ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> > +					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN,
> > +					 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN);
> 
> set_bits
> 
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> > +
> > +static int inv_icm42607_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	if (st->fifo.on > 1) {
> > +		st->fifo.on--;
> > +		return 0;
> > +	}
> > +
> > +	/* Set FIFO to 0 since iio core ignores teardown errors. */
> > +	st->fifo.on = 0;
> > +
> > +	/* set FIFO in bypass mode */
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
> > +			   INV_ICM42607_FIFO_CONFIG1_BYPASS);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* flush FIFO data */
> > +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> > +			   INV_ICM42607_SIGNAL_PATH_RESET_FIFO_FLUSH);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* disable FIFO threshold interrupt */
> > +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INT_SOURCE0,
> > +				 INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN, 0);
> 
> 	regmap_clear_bits()
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int inv_icm42607_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> > +	struct device *dev = regmap_get_device(st->map);
> > +	unsigned int sensor;
> > +	unsigned int *watermark;
> > +	int ret;
> > +
> > +	if (indio_dev == st->indio_gyro) {
> > +		sensor = INV_ICM42607_SENSOR_GYRO;
> > +		watermark = &st->fifo.watermark.gyro;
> > +	} else if (indio_dev == st->indio_accel) {
> > +		sensor = INV_ICM42607_SENSOR_ACCEL;
> > +		watermark = &st->fifo.watermark.accel;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&st->lock);
> > +
> > +	/*
> > +	 * FIFO enabled at update scan mode for accel or gyro, and
> > +	 * disabled here.
> > +	 */
> > +	ret = inv_icm42607_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> > +	*watermark = 0;
> 
> Add a comment on why this needs to be set to 0.  Normally that only
> matters at all if the fifo is on, so I guess something unusual here?

I think it's just resetting the watermark to 0 when shutting down,
not 100% sure though.

> 
> 
> > +	ret = inv_icm42607_buffer_update_watermark(st);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> > +out_unlock:
> > +	mutex_unlock(&st->lock);
> > +
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	return ret;
> > +}
> 
> > +int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
> > +				  unsigned int max)
> > +{
> > +	const void *accel, *gyro, *timestamp;
> > +	size_t i, max_count;
> > +	const s8 *temp;
> > +	ssize_t size;
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	/* reset all samples counters */
> > +	st->fifo.count = 0;
> > +	st->fifo.nb.gyro = 0;
> > +	st->fifo.nb.accel = 0;
> > +	st->fifo.nb.total = 0;
> > +
> > +	/* compute maximum FIFO read size */
> > +	if (max == 0)
> > +		max_count = sizeof(st->fifo.data);
> > +	else
> > +		max_count = min((max * inv_icm42607_get_packet_size(st->fifo.en)),
> > +				sizeof(st->fifo.data));
> > +
> > +	/* read FIFO count value */
> > +	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_FIFO_COUNTH,
> > +			       st->buffer, sizeof(u8) * 2);
> > +	if (ret)
> > +		return ret;
> > +	st->fifo.count = be16_to_cpup(st->buffer);
> 
> Might be ok to assume this is always a multiple of the scan size, but 
> maybe sanity check it to keep sashiko happy and remove that assumption
> of atomic update.
> 
> > +
> > +	/* check and clamp FIFO count value */
> > +	if (st->fifo.count == 0)
> > +		return 0;
> > +
> > +	st->fifo.count = min(st->fifo.count, max_count);
> > +
> > +	/* read all FIFO data in internal buffer */
> > +	ret = regmap_noinc_read(st->map, INV_ICM42607_REG_FIFO_DATA,
> > +				st->fifo.data, st->fifo.count);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* compute number of samples for each sensor */
> > +	for (i = 0; i < st->fifo.count; i += size) {
> > +		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
> > +				&accel, &gyro, &temp, &timestamp);
> > +		/* Make sure the size is at least 1 valid packet. */
> > +		if (size < INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE)
> > +			break;
> > +		/* Error if we are going to overflow the buffer. */
> > +		if (i + size > st->fifo.count)
> > +			return -EIO;
> > +		if (gyro != NULL && inv_icm42607_fifo_is_data_valid(gyro))
> > +			st->fifo.nb.gyro++;
> > +		if (accel != NULL && inv_icm42607_fifo_is_data_valid(accel))
> > +			st->fifo.nb.accel++;
> > +		st->fifo.nb.total++;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> > new file mode 100644
> > index 000000000000..b77deb66f8bd
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
> 
> > +
> > +/* FIFO data packet */
> > +struct inv_icm42607_fifo_sensor_data {
> > +	__be16 x;
> > +	__be16 y;
> > +	__be16 z;
> > +};
> 
> Sashiko is probably correct that this should be packed.
> Makes not difference here but it's not aligned in the places it's embedded
> in other structs and the compiler seeing this will assume it is aligned.
> 

So I should pack this instead of doing the "get_unaligned()" call?
Thank you.

> > +
> > +#define INV_ICM42607_FIFO_DATA_INVALID		-32768
> > +
> > +static inline bool
> > +inv_icm42607_fifo_is_data_valid(const struct inv_icm42607_fifo_sensor_data *s)
> > +{
> > +	s16 x, y, z;
> > +
> > +	x = be16_to_cpu(s->x);
> > +	y = be16_to_cpu(s->y);
> > +	z = be16_to_cpu(s->z);
> > +
> > +	if (x == INV_ICM42607_FIFO_DATA_INVALID &&
> > +	    y == INV_ICM42607_FIFO_DATA_INVALID &&
> > +	    z == INV_ICM42607_FIFO_DATA_INVALID)
> > +		return false;
> > +
> > +	return true;
> > +}
> 
