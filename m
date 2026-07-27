Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013016.outbound.protection.outlook.com [40.107.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73349FBE1;
	Mon, 27 Jul 2026 03:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785123957; cv=fail; b=NUeo+4Cim5QLwQ4zpNecim9FYkM3VmqaU+YHMYQpT70Mlj0qvYVhWh5IojfwFp6naHqB1C061fbrPM5hIMzvcxaFwcTZLyRlwkRygYuoCrKn5yFIz7QsIcJvIuvVDFeCGbqQOjmCjLgRugcgM9X4oej1H61oVKRQ2pUNNp3agjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785123957; c=relaxed/simple;
	bh=gvg7B+szbZU4Eysk1/zWeTLOOtppnNxc01owtNL6vbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0NDiNidynC5AvTga0xDxzxXdjJXMldHmkiHs22XIo9UNbewYjpCgTOOBzslAdl1Os7pSTRC3gXeAUR3GDf/euzH1545pUjBJT94w1zQp1RJgYC3Q65khulJR69YtqEuk57tAnViBAhO4vcVwrLU/T4LAuMi5MfF9vPQTn06cEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZrpGNwDJ; arc=fail smtp.client-ip=40.107.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZrpGNwDJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY76d0Ws+3PYnl6I27ImS+MPq7Bx7dwmGy2Rn4wGMXYhHvBAjXTUcbBaa8XJMbg7ptbjoXgZp7y3sC2EMgtisTr6bavGLvSgvF+iluaFrItWVg1ZUvKV+t7+l88QM1l9wtb9XiEJEllJETzOSU5ZVe2asyFR6cBvwQUpYAls9GE1pIzlaVOQq+V1XUXF7S6oLaUorxy67/jK3lP1GKcgnhVkRAZYqvrLqqMvv8lOeIbcn0PpUOhhue/TZM+1uYMMu6TLa1pc64N0bh6qsiJ8TyfxUt7TS26b3jjyw4uuejDDUgLVaZTyxIwZV1+j8EBcHTkR86HstRrj/9YGzASEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYLoAH1eHOSODJohAchg0Ma5qyL2axUWH7rMA+sO7ws=;
 b=fekbC966N35qAV9Eb1FDMEFoy1zWhs3vlTmaPRuvEHY6YOASSz/8Jbh+40sFd7yeTkNpzxj9CL6EBaw8wkxEos5X+tjhJhJGJqrK2pNufJ6MdA3TkMuDJHk4YVUAU2NjL5LUilD8Kk9c1txcZyzuP7in8zJ6ioGj6g24XEeYSvGnF/OZZXiUUc8pPXRTdyYbQKpZ7tOMnT+yLXquzZNY377wd7AK74doyWdLNoBAUhg3+r7XiGpGHd6MF5nu5QIKFmW22ja45X7wq+TEMjY1TCF6eximqaRVA4pSk/w5E7IXZgRCFkdObS+EsiIBLrEHkO/yNT1OMiCGMeUvfp8ZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYLoAH1eHOSODJohAchg0Ma5qyL2axUWH7rMA+sO7ws=;
 b=ZrpGNwDJZTp+VXklmwFd3gm+o4OEOa2by++i37MAEbFUM8VNlyuq5Oh+CHm9WYN0h/pmhUpIpKzDVKOmlfEUaocEnkIJXYQ5tdIi+wFhMrHM5v7TVeT1BrxPlxLm2Oj/LVT7NHPWBRRTD+1LaqcwRAPzHf9Sgysn1hmpGGb5z0oHkxShWipEwotkYXvh/4YuD2ta6SfRzdPlP+FtheDY90NhFllaRvEYtbxHz0q0biR9uOWxWjmYqIOH6uuIvFY1pK4lbZwYJk1Fu/cKb1vrn3jXdhWY/jUEbaZcpIvJwEcvLjFjGZ3J1BFLuyc8yLQl51dhE73XYVM4FsDTRQ7zMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEZPR06MB7176.apcprd06.prod.outlook.com (2603:1096:101:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 03:45:44 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 03:45:44 +0000
From: Pan Chuang <panchuang@vivo.com>
To: jic23@kernel.org
Cc: 579lpy@gmail.com,
	Achim.Gratz@Stromeko.DE,
	Michael.Hennerich@analog.com,
	afd@ti.com,
	ak@it-klinger.de,
	andy@kernel.org,
	anshulusr@gmail.com,
	antoniu.miclaus@analog.com,
	bhelgaas@google.com,
	bigeasy@linutronix.de,
	chuguangqing@inspur.com,
	clamor95@gmail.com,
	colin.i.king@gmail.com,
	dakr@kernel.org,
	dan@dlrobertson.com,
	dixitparmar19@gmail.com,
	dlechner@baylibre.com,
	email@sirat.me,
	gregkh@linuxfoundation.org,
	gustavograzs@gmail.com,
	i.shihao.999@gmail.com,
	jagathjog1996@gmail.com,
	javier.carrasco.cruz@gmail.com,
	joshua.crofts1@gmail.com,
	ktsai@capellamicro.com,
	kuurtb@gmail.com,
	lanzano.alex@gmail.com,
	limiao@kylinos.cn,
	linusw@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	lorenzo@kernel.org,
	m.gonella.bolduc@gmail.com,
	m32285159@gmail.com,
	marcelo.schmitt@analog.com,
	marcus.folkesson@gmail.com,
	mazziesaccount@gmail.com,
	muditsharma.info@gmail.com,
	nish.malpani25@gmail.com,
	nuno.sa@analog.com,
	o-takashi@sakamocchi.jp,
	panchuang@vivo.com,
	petre.rodan@subdimension.ro,
	puranjay@kernel.org,
	rafael.guimaraes.dias@usp.br,
	raskar.shree97@gmail.com,
	sakari.ailus@linux.intel.com,
	salah.triki@gmail.com,
	songqiang1304521@gmail.com,
	srinivas.pandruvada@linux.intel.com,
	subhajit.ghosh@tweaklogic.com,
	tduszyns@gmail.com,
	u.kleine-koenig@baylibre.com,
	waqar.hameed@axis.com,
	yashsuthar983@gmail.com,
	yasin.lee.x@gmail.com,
	ynorov@nvidia.com,
	zhao.xichao@vivo.com
Subject: Re: [PATCH v2 00/13] iio: Remove redundant error messages on IRQ request failure
Date: Mon, 27 Jul 2026 11:45:32 +0800
Message-Id: <20260727034532.311637-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260726212440.6fa412f2@jic23-huawei>
References: <20260726212440.6fa412f2@jic23-huawei>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0164.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::16) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEZPR06MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc8bdc7-2a4e-4b5f-2814-08deeb918958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|23010399003|38350700014|6133799003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jIBZUgod/895tyVpoouC9lGKBgiQos1CYFchYvZYdkIwxsUjSr6dlzskZdZcKtZzwbyxdT2Pd29hFCmvRqXR8VcjzW1GBN/iyI00k8JJL+BL9YSd0nJd+XmWoFKnmqxfwPod6o35tG8vdgj9rA2jHDKHXABEabrVaQYq33158YNBQrebcByf6xT4QEkn2LAQ4VjybnLbCHh+CZY54o9YFbXLpZCRzVSnSKoDnNBuo3kmuuTbH+FlpyWQvzCk2GHp6PmI8g7DjpKQrMGCxKoSQizLnvmNuWxW5RLysQzpJfr1zeBBrcFlb4+1GGNz8ujSKPJRdf0JvLQA0xkaqwOWH+uZduRfwjleDvVWdg0GYC4LsJ0sYKmiHFbljcZc5TXNVdQkLzAzmwhrLWLlGTDP/xxqDSC8MLFTF+Tb8ZOc0STXMGSmFoUWeWyzy0EMSMnfin9m77W1WXtAmNon/diYqLWBoGogoq/pAAiwVH7gPrs4dEBweFhf5DoKpMf5z7albpL1VEUMNkFKRVtqNfLKgV3WAuxGjcx6FQX5VQBiUVB5gPfRsjrHewBp9OWSCpt7dDqpPi+KKibtWjSsl3wwG9A4KevKW/WrQ2ansIIbyg+LDU73c6CjJUcRCxtAvrLXPVasYrSG92Migou/JGJawv2M1ICeeEFdKEBb7plwKwTbVAIEfM0JTyqqtXpuCcWKuFtBSAJfJHbMF9JGB0qSwx08+C4qHult1BmrP9tEilE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBdVF08LfO2kl8JI0i+WW7cJ+eJIEja8n5unmmNlcP9J0vREfT2KBA49eAed?=
 =?us-ascii?Q?ldIMDykbg5ilETfKFob5WqHq2gO31wouWng7PCqnS4/R7e1QEhdi59x59pfP?=
 =?us-ascii?Q?7N5tKrCN+9PReq8PHt10e0AliBK3OCyOJIRw8WLSE0FxHfb67xKB7PFwxAeq?=
 =?us-ascii?Q?54sy/krPathCFLOfZA0ROFYnIUtI5DcdUkDirQqIk/+ry6OKeD2YGtR9fzB3?=
 =?us-ascii?Q?ejAz+CANtMAyuRL25uFoAqs1omTnd2SIGQwT+LCyzkm163vU+oyuvrA+0g4t?=
 =?us-ascii?Q?dgbBgaLbojuGIoqYKDELFoEJVJuW+fWyVdgBlhIXxBRc35hA8pv3Nqz9yiqr?=
 =?us-ascii?Q?O1DdH3M0jeQh1V98aDBBfyzXNIp4bZQ8CajzbJEU2dJOk34SE1twTa9tr8Yv?=
 =?us-ascii?Q?ZmiYmUnlf9XXCa+bMoVIesvJbG1sVfIWAGeO56EVuJpTJJaOUm2mqg0X2bl8?=
 =?us-ascii?Q?d4RxZpCb35zfgUzuwm4N+DZCMn4WS3aeVpb7ijJuzWTl++2hpiSZsaWpYdaU?=
 =?us-ascii?Q?6+vzHSTK6O8vQCpE3F8xwyqMQE+foLJcHlQI8oLQMVCduYZFo6OIMki8joP1?=
 =?us-ascii?Q?+MQOg3nNGiKypXFJ8aJEGGbL3oFg40lWZwSiTq8Y5MMlhcJ4CWHcSrLblYry?=
 =?us-ascii?Q?BUMblHUUcdOEeYcE0JklCUHQc+I++VHpzJwVPyBi1AXvYdLYohfWIjO+8KYk?=
 =?us-ascii?Q?kEF2JUY4khirjTdL15xc9Z/87q5n8D37jj2Xeu49U+jJeQt5Wd0velYuTQEL?=
 =?us-ascii?Q?jH5BgH8dzIsdZM8921bfGqhoJl81rkJVdilG9qHS98PvCEJ2uNWJObIPI0Vj?=
 =?us-ascii?Q?ktZQCUYQF+VB0JtGvRucryZaq9TZq5vleaphIFzuSgTQMOLlgIUaB6vMAV43?=
 =?us-ascii?Q?CE+1QL8sP59kE7i2PASOvmlmQKUZwU9pNRGAKwmqSRoeTDDpCVYJLpVYzBdY?=
 =?us-ascii?Q?5MxqcUmMMfjfINbN7Sa4LuhyPnoi1BYwk/ssCLYCifXkRpxxrnJK3I+1QPuv?=
 =?us-ascii?Q?4+jnj0VLIja8ZCyFQmzMonNt0N9VBu0j4UcWD67JFJscb5sXmAYGNNmX5qFb?=
 =?us-ascii?Q?gjba1byrFTUnvHBPqdAjiPtc9bsB3hWdKnkmeI+4FUnWJBo+cmtG2kp28lr+?=
 =?us-ascii?Q?tdrz4ap9uExSPZ0Hvl8V2FN7593oby3NSoQR87ivVYQM1z9yIptIjPuPUp14?=
 =?us-ascii?Q?tqSUOZV+COUfkPJIfn5T+3Ffo2RBlWpZrBj1jUSffnEkdJXo1OPKBhvDqFFJ?=
 =?us-ascii?Q?yJzVex4rL6L6U7eEqb5zBBudvdORAsgVtCcgr617JlvXnaUBqtIzFpW82Fhq?=
 =?us-ascii?Q?/e3isq7A1A4MfZSp1a+sB4auFI97FCChrv/+yUMwLXRBPSFnIP0wi/Ie+GdK?=
 =?us-ascii?Q?yZ0uWdbHVZFMMuZVFBFHMIdyAhLcRLxxf046Eu19lgYG9DTYrusuMV9mD/6o?=
 =?us-ascii?Q?8pc7EOnFjZSB/klb+c7bBY7GBfLULj7h++6o8ox1N56b86bb0q5Srsujk5L3?=
 =?us-ascii?Q?vAC/TcQ4focp/bzio4WD1dnnNIIwNxtJGlSGPrjyV9hup+vlFHn5q/+Engk/?=
 =?us-ascii?Q?Zy61EJ0ufk2aMCeLlFaLGWSr+9F3CrhNfAZeZTT7HUC0qN2BW5nqfQQ7E0ey?=
 =?us-ascii?Q?7/OiUg2ALyUevCN5hRzhuJfdZ9pe35VfuvUgon2GwnJijaHykkKzWYOmp+bA?=
 =?us-ascii?Q?KfPjjUTvuGjPK6pXOvNLhH3cu4kvzjOAurqrmBvPziuegC7pzwH78KXv49R1?=
 =?us-ascii?Q?B/VWitaCUQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc8bdc7-2a4e-4b5f-2814-08deeb918958
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 03:45:44.3155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Pv9plFIj9JJZX9vG+Oof2Pkbyau+vU/LVm+d8E0lTA++jvtN5yuA4WbeYEYw0LfB+aZFNCvyo2cQnFRnSOFWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7176



On 2026/7/27 4:24, Jonathan Cameron wrote:
> On Sun, 26 Jul 2026 20:59:41 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Fri, 24 Jul 2026 12:27:01 +0200
>> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>>
>>> On Fri, 24 Jul 2026 11:03:35 +0800
>>> Pan Chuang <panchuang@vivo.com> wrote:
>>>   
>>>> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()")
>>>> added automatic error logging to devm_request_threaded_irq() and
>>>> devm_request_any_context_irq() via the new devm_request_result() helper,
>>>> which prints device name, IRQ number, handler functions, and error code
>>>> on failure.
>>>>
>>>> Since devm_request_irq() is a static inline wrapper around
>>>> devm_request_threaded_irq(), it also benefits from this
>>>> automatic logging.
>>>>
>>>> Remove the now-redundant dev_err() and dev_err_probe() calls
>>>> in iio drivers that follow these devm_request_*_irq()
>>>> functions, as the core now provides more detailed diagnostic
>>>> information on failure.
>>>>
>>>> v2:
>>>> - Rewrap commit description to one line.
>>>> - Drop redundant "!= 0" and "< 0" comparisons.
>>>>     
>>>
>>> Okay, code-wise it's fine, but rewrap your commit messages to 72
>>> characters per line.   
>>
>> That would involve breaking the commit reference across lines.
>> I asked that the author not do that on the previous version because
>> it'll make it harder to search for if anyone ever wants to do so.
>>
>> Also submitting patches suggests 75 chars. I'm not sure where the 72
>> comes from, though it is often quoted and another bit of submitting
>> patches does say 70 to 75.
>>
>
> Picked up series with a few tweaks to call out where if (ret < 0)
> changes occurred and making sure Andy's RB actually got added.
> There was enough changing in here that b4's fuzzy matching missed
> sometimes.
>
> Pan, please be careful to pick up given tags on future patch sets.
>
> Thanks,
>
> Jonathan
>
Thank you for the work on this series. Apologies for the oversight
regarding the tags. I will ensure given tags are correctly picked up
in future patch sets.

Best Regards,

PanChuang
>
>>
>>
>>> Feel free to apply my tag for the whole series:
>>>
>>> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>>>
>>> Also, I was scratching my head at how enormous the To: list is, given
>>> these changes are only in IIO, but I assume you also added emails of
>>> the people who authored the latest changes on a file that get_maintainer
>>> outputs - there is no need to do this. Tools like b4 can automatically
>>> add (correct) recipients based on get_maintainer.pl
>>>   
>>
>>
>

