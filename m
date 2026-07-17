Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E739BFF8
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784330776; cv=none; b=lkKl5pNZxH2Ht/udrxluQxntOAXxI9xXdQa5ceYHe5Wz9nRxWalPED1nccSTCdzGio/I4vzMM2nMItg7umN/ybu92Nn2nsr8008LXO8xlgRS+ZjQ1RrlJP0WVlH6DJ+869H6iSWZs7a1hWeoAiRbHxbttq/9t3445qNiQNFUBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784330776; c=relaxed/simple;
	bh=Mr+M2V4EySH5w/o6fGZtPCNFPSb1eKpwfb+NSwiNkmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSz5QjkRIafAF6E4fjSUm7s8TfZxqqZkQ9dfHn8r+IFsHS0w55De0aw6dD4ZsfVIHrXZrmjPaEZLAf/bBZnINWo9wFrLA/kh2icAEtWL+ykp40j2UT3fUgF0M3G+owlejK98sfn3vJNlGfHeS6agA+0EyI1fuy0jy1UZiiDUyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZLklD+Vs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dBGheRRl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLklD+Vs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dBGheRRl"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HNELfG3023738
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EKroq+M5025DWWLFFadkmaK5KHqMFcN31yiR+hQHEZQ=; b=ZLklD+VsSssVWiGq
	f/Win387NUnx5O1S21B9OdUO2RRUc94tZfdlDUyifphhsek6kfUnENTElQ0z8/GH
	ic5jMJcZCrTSKgaKYYZ7+QQRncZXnaMo5F/5uwDMlCe01YIljGOCq38pV7j/WHKI
	BLjYlBerUDP2qwzEj0JChczc41pj+OJRf66uP6EurFOwSxqLaQE0smdltz95A6px
	rL/fasyyNwsWkpG0RNpCS+yozLQb0Twn5vFeu/wjkuwc/veLBL+xN/C9Xoujtl7b
	VkmXp2ZECc2GgR9PZulAMsitWjNFar6zBI806eloCHMQbtJiek+1e6MORtHyrzGv
	uHvpSQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrp8s74w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 23:26:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso103033655ad.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784330774; x=1784935574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EKroq+M5025DWWLFFadkmaK5KHqMFcN31yiR+hQHEZQ=;
        b=dBGheRRlB1glWCKdKJSO8Out82HSNyNMBXFxANizSz3M/9Z4oq5ZliByPLTTvK4Pau
         ARmjhqR+yco2UaPFM9no8chOe5mWNmMR1WcqJ5k915N6I136aIpxBmnIaYhjYDqEnCzx
         Fbkuhwfbr/bHHztevQ4c5/7t4ZD2hRmGl8mtEA4o+AkCAIIH9YdTUtVCHkGYRG0pKKgr
         JVSOpbefrmIEOcu/F3H8PxdC1QylAGPceZTDgL3E8eP17Sd95h1PriQ7S+v/x7F+IuMy
         NEF6JKRppHwI4SfvLKSB+cHwr2W43bqUEJebtNkDI7z78ayYP04dR5qlI9HSV+ABAzQo
         N8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784330774; x=1784935574;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKroq+M5025DWWLFFadkmaK5KHqMFcN31yiR+hQHEZQ=;
        b=dVphQZS/lzRebs3FgZp1Hqtad1r2rqxUOziylxgLTM7DLeKKh8YYOdO356dOa3os2n
         FwuQyXfxXTBYj8bBZfmXUv48A85NrGpJqW4iFhDfuxhDbzrv7T4GJeA/k4594OgVn5s9
         MTVajL8HD+s4jccXI7OQWIxdS2SQKcyJiCb21g/7bk4cXKyMuWgPpt8gScBQLDrwbmem
         GAC8GBuSslthMnbVL85slPKCBPytGxiUyepTaNAB43ChgaXwiIWIHL4oQcqYegXjOtTJ
         G43BvEm/zqRWb0+Mzavy6FNXH8/EhM6FH+8+SDfkp0eRbNJiPzGyoT4kQB+98RO6B4LU
         i+gw==
X-Forwarded-Encrypted: i=1; AHgh+RrUqV61UuXRPj6GRt5aVCszRF7qAAJ+W5DJKTrqTLW8QQGNSpAlrj/3uIFQv/hM/SqCozH9G9ehmUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQuNpjqzLUEF5QTBxLXe8EmJLvENXu1JH5EdF2qJHQu1o4G8P
	OhUFDbJs3GbZklHDohqMyJhxP36B4daUMURJOySACEnkoVzKFSpEz5TotQlW7xNOg9xcU4TKby2
	BfKSK9fxCRq8LgNehEqKYH0trVw8AkFqCnHeQUy1LNUcNOB1JH/9tojH3NAAky8Q=
X-Gm-Gg: AfdE7ckGOcPM1VNAUguGFcCF/lL6wteMQEdPYlPRNFzRmDj9AFcxzWuWztjDpEaXMT3
	06SKeHy6gXxztX0dn9aFOdJW7cQSezL3ImwvssxUxVwFv2cCQsY1gDj3Me4MCMMLDDc0y0qJKgi
	UmyQDeXgOgVbJy0T1sw7J10sqcLPJiVynwh4vnWULnKxbO1OZiaup4P4boKgzXt8EHTy+eVxGzW
	95ZmykwcpBiD603lQI4T81cC2Jd2PEDWh+wm4AErG4LhiFT4vOXYSCuIYi/KRG9Q7h/4tgvntf8
	7biCDjVqtsOOwCsGtxF3Q3FjLYIndSHn1KWVEOVJakFyXFhOi5XEhn1TSp76eDY/03fNE283OAG
	0MElEW6HxN+jYcAKM
X-Received: by 2002:a17:902:f688:b0:2ca:5d24:720b with SMTP id d9443c01a7336-2cf349caff7mr53608565ad.39.1784330773720;
        Fri, 17 Jul 2026 16:26:13 -0700 (PDT)
X-Received: by 2002:a17:902:f688:b0:2ca:5d24:720b with SMTP id d9443c01a7336-2cf349caff7mr53608265ad.39.1784330773302;
        Fri, 17 Jul 2026 16:26:13 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3473ba1dsm18246615ad.65.2026.07.17.16.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:26:12 -0700 (PDT)
Date: Sat, 18 Jul 2026 00:26:09 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 04/13] iio: common: Remove redundant dev_err()
Message-ID: <20260718002557.2e530d50@jic23-huawei>
In-Reply-To: <20260717094408.509583-5-panchuang@vivo.com>
References: <20260717094408.509583-1-panchuang@vivo.com>
	<20260717094408.509583-5-panchuang@vivo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXw/cY4t34Ctdg
 /eqj3kUyF6VXccu+MGKfjBYps7VHQLX2lTj7qI84FKFNNRV4gU32U+AnabHSazvussOq/txpGOt
 iDoSlpQhUdes17UCXklm4hXfZnV2MMM=
X-Proofpoint-ORIG-GUID: 1w8YdiuR7E-CfZx7D2WgqPZ_TM8CR4QK
X-Proofpoint-GUID: 1w8YdiuR7E-CfZx7D2WgqPZ_TM8CR4QK
X-Authority-Analysis: v=2.4 cv=fMYJG5ae c=1 sm=1 tr=0 ts=6a5aba16 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=1WtWmnkvAAAA:8 a=hhBeVE5wmSm3c_K4xCsA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX7I/3yItlbVVh
 NZVa781wUPi3Fhn+PJb2Xp1AzbxfpwYukXsV6BiYmOsjzJ2VBvARWbMj5v8/l10bk7fd0m22sq5
 GYJ+NTJg2XSMFrMC/ygJszFShhSNWDUkeHUOkfysz4w745/spenSXmIUZHud9QuNxGJ9gpRqt/n
 xZUNIAeZSA7hWBdD9UJeEMjQBENVxV/D7F2h/IZ3M4EsVVIFOCBegXT99EsZIT1cHjjABeVivzF
 oCzOzv9km8DRRB456nsljC2QYj3dtETCzTvVC+UHXtNYaC7S7Puxz3vG9iOzEIKXl1JO/aHdo9I
 wyRcTtqEoIb8jKrnv/NMhR4A2jnWCABkHiCV6jUh72sMPj2TnIP5coWi8hPQcdVZJqexqbO5T8D
 mHsDpzIPyeebatPK88klyq0XYiDQ5g989C5oA6B4e+5WA0YT3qecl+G5J8Kc6W0rJ2LYmax1K53
 yfix8VCeP+rNCbPs94Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170241

On Fri, 17 Jul 2026 17:42:27 +0800
Pan Chuang <panchuang@vivo.com> wrote:

Hi,

Where there is only one driver affected, please name that driver
in the commit message.  Let's anyone who cares about other drivers
in that directory know they can ignore it!

Thanks,

Jonathan


> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 8a8ab688d798..7b3e9732cc3e 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -211,10 +211,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  					irq_trig,
>  					sdata->trig->name,
>  					sdata->trig);
> -	if (err) {
> -		dev_err(parent, "failed to request trigger IRQ.\n");
> +	if (err)
>  		return err;
> -	}
>  
>  	err = devm_iio_trigger_register(parent, sdata->trig);
>  	if (err < 0) {

