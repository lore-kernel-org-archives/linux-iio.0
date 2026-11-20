Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795196443;
	b=zLC0/4+bhvXqQUTogpVCpyKedIoHBBYrr2TGLdNB6HHCQmRnJCPXRg1bgTtyILF+On1x
	 HqRBlg/EJ3yETMucOuvy5RpF0zkbQn4bua8sqdQbUd31DmpEpbPoj43b0y73UyTDQdGAM
	 p+56GpKjw3PiYoliZ+5hvgKK8ZalRYUbr8qiS3bf+h+pnSauT3A4c4coS48F5ikFeuaA7
	 VckiLk40RmMfusnd4ow0y5hfeSNtFvL5nnaSWE7djsH2vJjKeyLHCEjBSHZMYrPsw7rp/
	 NYhSuSgHDkcr7hBEF8gZIb3xcg7TVC/RpL9hg5ZAFkWr0hIaIbMeTylAFh/WqKGxP3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196443;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=D3ZzTfLUKU1qAt/S5wCuGzzVkwvzVwkyhqmsFirEIh4=;
	b=iRTyw3nC3wGJqOJ38IzY3FnxVQ80iSQvgGnqoVuISLYK44Nnn/0efTqi1qWexOBracCV
	 RCwtq9wyXTKRF20qr26TQ54HKXmrLbFlZ/kP55AWUsY2ap31DtpeG/tHdImuXOYLlCxJI
	 hyrEsaj6o3q4rtTWsVnfTe03yX6JI/jrlu/18+lyj0SvYA7GZevo4PAQC+LJYkZ9mjCpv
	 rn1W95RB4bexccAxOVa6WobKD5ZYPYZMW5eRp/ng9rOS+kn3JDDiAiV19a9dERORJiPxt
	 kffBENeXUhVEhzng+YrEhawdIr6+RsE4UJWg7UdWCmTOrrco2SqBeNJDflvR6ccYqMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=IEAzAAVX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.31
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F2606A33C;
	Fri, 20 Nov 2026 17:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0F2606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=IEAzAAVX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1Y13+xF/xN/qxzvLwC/u6dpxGXtSbSBO+YVAnEaF1JWqLST1Cj5NtzCBlpjguqkgX9UF2MtmItp1gXI5pYWBtGo5qg6jzHRmrY1qDjCQFvLBMdDzU/5Ajsy0t3pmRdUfRYtXZS2LFMghjGMoeFi1w8NKwIqYie00R5Fpq25Ys0/lTfPfE0vqctYCm76nQ6qiUAxkQy92idz07ZHONuXbYCDkugQH53DlBBAp3Hmv5XxzCJYqWDYjF2jxJMjfi/fFyviPp3Woprf5vMVp72TmBTajMm01JS7zSsIl4xCcyQrkPSJHMdtDW0BrWlxgdyQW9fbulKYyd98yRbwh4l+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3ZzTfLUKU1qAt/S5wCuGzzVkwvzVwkyhqmsFirEIh4=;
 b=oxDWHP1G3Njc/bc7tJi43+xhctS5nIq8GP4l+ZdfWspeQtkdHzRmpjJ0S8S3g0jqhUJEdhQMZUKuOr+jj4cXIQ6+ssJyJ2i0KBs2bndPqRIkmDZ2CcMV5gaz8lbCIplsbUqFJ3vQx9zvgXKserHAXqEI96KsX29Fn7W7Upt4SKKmj8m3oXt7ZR7Qn3MwpbXGppzTLEKm5PyGMytYFNT8qTUzbxvMJorLF3FmAoFLcA1VZN8bJDoq0V6yP7+5sY/5wWflRQjibVDkSxuZvC1tiwJl4+uIZK5fCPKoiFGxpbZJcpNjtec78JqRM1WoifhJZqG4MNKizC6IAid8fSbXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=cmss.chinamobile.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ZzTfLUKU1qAt/S5wCuGzzVkwvzVwkyhqmsFirEIh4=;
 b=IEAzAAVXlXMbedSnTbQUgAIl39VEJ1tSC3xI/AL+ThZTnnL4v8oHdF/DWwz8JwUVfaig8B2tCxEyJWS9yA7lepnpx4uoyrXu5zVkNPpWVW2YrohdiHL/h6A7LqJc3ukvfAdtCtChLXOcuKQ53Hg5JXg33FCBh+qtZ4PJX8t15RH2xqh6h+1zgvX6jY98P0e2/z/HkTqGZ3zCwKDxwupDqF9PlYABj8p6ARXOthTQCa0YX0w2Ms9n/zoVjMzY36l6xvvxT6bcCtcR7hiUxRn2plYiOL36swDk8sFkS/+WsaqiAKx1w/u+QuNxfqp/Kg613/FwRRPQ3C1k2c1+Dc7V1w==
Received: from CPCP307CA0001.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::11) by
 AS1PR10MB5698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.1; Fri, 20 Nov 2026 17:40:34 +0000
Received: from CPH1EPF00000528.eurprd05.prod.outlook.com
 (2603:10a6:380:0:cafe::73) by CPCP307CA0001.outlook.office365.com
 (2603:10a6:380::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 17:40:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 CPH1EPF00000528.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 17:40:32 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 18:41:35 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 18:40:31 +0100
Message-ID: <32296215-1101-453e-bdb5-617c2a32df0b@foss.st.com>
Date: Fri, 20 Nov 2026 18:40:31 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/counter: Reject invalid watch fields before
 narrowing
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
CC: <wbg@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261120061932.98210-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20261120061932.98210-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000528:EE_|AS1PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: af84da59-204b-4023-970c-08df472d60a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261102123227099003|261009223027099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	LSk4P8CMN40S/bnzPH4k8XxMNq56esnKIenVRP2TR4/D4nps6j8nCNFB2KxIfV+hdgfrrjinAHzMWqnyoohgFWGKq6A15/b8KF7MK6LQiQ8uU6roneKKlhDgFiy0V7YO0wRJ+YCnVd3ZlJMdk3D6DUo2UT9Tk/9oEA1YCzVhPWBpQQxI5onQYT9q8dZ0dM7BU/RdcOe7VfuA/LSWkCjZVZAaKQzBMi0XQY7+4mT5cq4z1Tp5IBH0E3cI1dnOwzwzeq0A2bKOyZ8mM5EcdMAz+4oPPUeDYBrE2iezLWErhU3VgkhJoTm57FL2KKtq/6i4PXlhovQt/7D7wCMMVlfUxw/9ojUvharq2SWjViZ7hDRJTAE5A86TBsHLXQyfHL/dljrA8MHliyunmvP11T0ZPRaf/esF1XvMponxyhdOJoCk9/YoMWT5yt6XCWP/6aR3/h1LnUbIis2IYXnr47ukYlOsd9Ot+1vcAv31oEFgSzG28QiIZQwQs2TM1tHkNz9k1PW5rA8z0BDt9NFvy9viIz4nX1k6xmNnkXmjCPrftLcHfMOHz0+t/xBgeMEPSE/OtsTWrLYMVKoy2O39GysmHVlw9S5T/r62B+7h9rfUy5575tbX1ZCF0XVRr1Imr4uktuacgM6X/FzvIETOVaN7Q0GShDgqWfQOZULqwaPfKCn/oYDANEKFrJWd/BlFsfCw
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261102123227099003)(261009223027099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K4NYSBPo6OFKCzWP3hDSL/AzQZEZvpirSeP4rjY405CPLml/2tWCmUhFrneXsIxJ9myy4RvNfOYuoMAH+fdGgqjHf5322FbOJO5l443A4wjluxTGqCepVb9zcwuA4wY5N7u8EmkOSsKMKH+otSCy4abbRgqSnsbqrfWDnSfTEBXK9mGQyG1LWLivPwx52P7He2y3HE92haicdLo1C1RiZY449sE8XnS2QtcMvwzfZfryZ3iU8+5UtS+w+EIoxjdJASdwSJtWKVYjws0MoAxXRC0TEfW/b8D6kMJQcZsI0Hw0i5118mftaYj41L+1DvbBJWZCI71A2go9lyJkKCMziv7Q50mEq1NKJR81ylJyyekWIjNZkfXcKGxxTojgcJ0Uu+Z+ErHv6h/b4vQykAk72yv2LNGpawn74bZLpxwc6x5ataog//bJSCgxb5kXUjXa
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 17:40:32.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af84da59-204b-4023-970c-08df472d60a8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000528.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5698

On 11/20/26 07:19, Zhu Jun wrote:
> The channel, component ID and parent fields are all eight bits wide.
> The current parser accepts trailing characters and silently narrows
> values above 255, which can select the wrong counter watch. Parse
> these fields before assignment and only accept a value in range.
> 
> Fixes: 1e73427f6635 ("tools/counter: add a flexible watch events tool")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---

Hi Zhu

Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Thanks,
Fabrice

>  tools/counter/counter_watch_events.c | 51 ++++++++++------------------
>  1 file changed, 18 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
> index 15e21b0c5ffd..432a0cb9d300 100644
> --- a/tools/counter/counter_watch_events.c
> +++ b/tools/counter/counter_watch_events.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> +#include <stdint.h>
>  #include <string.h>
>  #include <sys/ioctl.h>
>  #include <unistd.h>
> @@ -288,44 +289,28 @@ int main(int argc, char **argv)
>  					watches[i].event = ret;
>  					break;
>  				case WATCH_CHANNEL:
> -					if (!value) {
> -						fprintf(stderr, "Invalid chan=<number>\n");
> -						rc = EXIT_FAILURE;
> -						goto err_free_watches;
> -					}
> -					watches[i].channel = strtoul(value, NULL, 10);
> -					if (errno) {
> -						perror("strtoul failed: chan=<number>\n");
> -						rc = EXIT_FAILURE;
> -						goto err_free_watches;
> -					}
> -					break;
>  				case WATCH_ID:
> -					if (!value) {
> -						fprintf(stderr, "Invalid id=<number>\n");
> -						rc = EXIT_FAILURE;
> -						goto err_free_watches;
> -					}
> -					watches[i].component.id = strtoul(value, NULL, 10);
> -					if (errno) {
> -						perror("strtoul failed: id=<number>\n");
> -						rc = EXIT_FAILURE;
> -						goto err_free_watches;
> -					}
> -					break;
> -				case WATCH_PARENT:
> -					if (!value) {
> -						fprintf(stderr, "Invalid parent=<number>\n");
> -						rc = EXIT_FAILURE;
> -						goto err_free_watches;
> -					}
> -					watches[i].component.parent = strtoul(value, NULL, 10);
> -					if (errno) {
> -						perror("strtoul failed: parent=<number>\n");
> +				case WATCH_PARENT: {
> +					long num;
> +					char *end;
> +
> +					errno = 0;
> +					num = value ? strtol(value, &end, 10) : -1;
> +					if (!value || end == value || *end || errno ||
> +					    num < 0 || num > UINT8_MAX) {
> +						fprintf(stderr, "Invalid value for %s\n",
> +							counter_watch_subopts[ret]);
>  						rc = EXIT_FAILURE;
>  						goto err_free_watches;
>  					}
> +					if (ret == WATCH_CHANNEL)
> +						watches[i].channel = num;
> +					else if (ret == WATCH_ID)
> +						watches[i].component.id = num;
> +					else
> +						watches[i].component.parent = num;
>  					break;
> +				}
>  				default:
>  					fprintf(stderr, "Unknown suboption '%s'\n", value);
>  					rc = EXIT_FAILURE;
> 
> 

