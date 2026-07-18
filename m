Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FF1D6DB5
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784412059; cv=none; b=pgH+DD9iTgO5DZP0p3oZORjvJ6uRuMcKkgpSiy086mtsUAXQdMZU7/v5bOqG7s7bR9SBSEX9FnJCskdSYV+v/eG/zx9/QWNpBPxOTb9HCnP5z03Z7j8wApGZsavm+3/TLvnAkwclaDzcofkq0Ky84UtnHlLleXSCTS4E0U3VR0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784412059; c=relaxed/simple;
	bh=ghYlqvLKt0/cMTVKqnu8zwIKwlK0pqI+GKZep1Vvynk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1KMyn/sEhbQtfIs1joRHDqFXU8ZW2dQ27z6y0MJ0LA9hmfnVENSpNxro+PfROGxLozt+oYamSghO3Skj66JhiwaKRUZfTTwjTmosnS0wo+UEsQHfknhLECg60yB+GqlAq2JKyzMNQq3eiSMtW7PCEQVuXZcz/7U8gKJhY5CWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=REAVnpkM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TPjuT2nz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="REAVnpkM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TPjuT2nz"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJtJ7k1672964
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Miz8KGebrcURqqzxwczxNO7UgR0aqbaEZxfBca1IrQw=; b=REAVnpkMis9qKOoQ
	Gjsg3K/o2M+DcLAkQNK2M9MPuds+uaJSjVTVguT35oRyu+fno46B/wavhqArWifG
	SyaziYAj+/noPOtUL+yEFZ8xIJKYRYZUl271IuRLHJgi8g+Qg+ydOjXZPRxrgqXQ
	JdATzhyxivmaASMRX59fQpoVBVNTYlAZtIUjXE/DwFqkJG13ov/i0MIGGZnDeYkz
	mAtThmPEVQMpubPv72LbqdCKiomm1AMjsnSSpeYmNcYOfvndpybO/LomC/L+nb1+
	Vdsk5WHoMi6T3GZNKFi9hlugV7J5+ssubL1zr48lP4ic1tGFU6jabD2tI4owVTSp
	lbeF6g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af1m98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 22:00:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1681141a12.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 15:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784412056; x=1785016856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Miz8KGebrcURqqzxwczxNO7UgR0aqbaEZxfBca1IrQw=;
        b=TPjuT2nzVNWfr/c/yn4vJhhhS9SCUSbc2UTOIfHatbF6mmh09iAujJU5cIM4HJthnQ
         SxOevXFTAWFSVB5zSCWKiXf8a0EuHTVTFHEEXuTfIK7jjWklAN6l1QmONV7epDgkGO/x
         NOfWUKVypHlC3VKkS/Nilw8QRjYVVGur+MXHyuS5BbF7YLyv7ItGsPQWcX1s663FrMAK
         jQZcGsSUN37W+3WXAn83Lj+8TrhItw/ghVg6OS2PtHAtIfiewowZynvhmpl6QTx33CBy
         t6it3puR7eIsOQDQ8Px0b9RrrPIUmm9cjWsQmpJ1d/dadkiqVwIUQKGw6QJy1Hclx3UR
         Sutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784412056; x=1785016856;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Miz8KGebrcURqqzxwczxNO7UgR0aqbaEZxfBca1IrQw=;
        b=HcFryPGH8s5M9F8JN7zjbmuPBWDZrMsS7JM1ZKPzm4o6A+RA0a0N2xD9/pVpmEypsw
         zIs8FGlHcl0b5BCWb+4R8abaKfQB3sY02976xmXn6+ORqpNXXlSYriJc70DrJMqWHK6F
         QVpSAE45GrF6PYACucg+l/yQWnGkGaKG3p707h6n+IT0C78DIl9jkSxDI/EgqaPSDgKl
         BPFlPiDS+sKdof2D2Benovzb8HqJ5tDltHSb4LhsjM8xu4LClb+yMeeGgVbPPvNPN2qi
         dcV/M+GL2xkpK8b0M9js/3C49cfIxvewEk+kPKbSTJdvuDt8ci8nX+NxdjxAcxlhg1Mo
         8PXw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+ZS8Nv8FMg34WQqRFgOAu1uLL9By9TPykEIgHdJ14G7z2hRHdfUoAutOjzbJC2/+9re4FgkhAAk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XdfehEnJ4llOeNEh6ef5Bt+xaMXnbEySY25X9tTGf5BXruDt
	6hmJhv7hcnnGPY3MZHOdiS7IOb+qRITYRONKjb9wP0SLdnlGe4tJkR2UwcSsRQU0k0C1P8X7dct
	AJ2Ft3BDAxV0RSw5nMHsySZhB9CezxUqqvpfAcYUOR74RsYD2iP8hqD62AAt43Ys=
X-Gm-Gg: AfdE7clrdlGLVduR5hV2nyJL68g3o3P65AKuthe1tgYEOLQlK6mLsy9Z2yGqdf2mZZ+
	8P2n/TjeZ4cYVtdIrbVqRw15wUPevnbP5qiM6jDiOp732zFOluRJRRpExTa9Y25kOPyIdZ3khxY
	kjosGMDphp5iAHePJaM4dmxgR9HOwekqrqrLvObAI91EvDt9ooUNFz7C2Lc9IXKTNF5ZRikbAVx
	A73eKOWFzU32EISGxeoixvUuPaneWltGyOkyWXcaTvJsiIJ3nYmRJf1HX8q4mGWNJlV1qhmvEX+
	BtSRk1tXByxnyVanmrkr0GYVZzI9schXhpo9imqrkaGy9sp8+i0kovxH5YXJcZPFtqxFggCgCjy
	RLmVHK/+mBUFbvGtG
X-Received: by 2002:a05:6a20:a11b:b0:3b5:530d:d96d with SMTP id adf61e73a8af0-3c3acc978dcmr8272371637.12.1784412055824;
        Sat, 18 Jul 2026 15:00:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11b:b0:3b5:530d:d96d with SMTP id adf61e73a8af0-3c3acc978dcmr8272322637.12.1784412055316;
        Sat, 18 Jul 2026 15:00:55 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517aad770sm2391073a12.2.2026.07.18.15.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 15:00:54 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:00:50 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Andy Shevchenko
 <andriy.shevchenko@intel.com>,
        Angelo Dureghello
 <adureghello@baylibre.com>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: dac: ad3552r-hs: fix scnprintf() buffer bound
 in data source show
Message-ID: <20260718230050.2c64d9fa@jic23-huawei>
In-Reply-To: <20260718182236.7-1-bbnpreetsingh@gmail.com>
References: <20260718182236.7-1-bbnpreetsingh@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIzMSBTYWx0ZWRfX2dZfpQBJa2wY
 o026iKEqKsxkCfmrsrJC1WLNa1koNPL4jRs6vWLYh9crI9U94cjS29jN933CXiDUkpuszU5Z+pq
 CWcYLMm8rz61/GxuuTNP5n7jsKMo1Bc=
X-Proofpoint-GUID: HZDncIQRmD7ekO-2qobDhKV0ZaMhRWOG
X-Proofpoint-ORIG-GUID: HZDncIQRmD7ekO-2qobDhKV0ZaMhRWOG
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5bf798 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=d46Ztn4Rf3i8j93KB0cA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIzMSBTYWx0ZWRfXw/v6C4d0uWX7
 G+J/U3dYiNlamcaM+eE8NroA0ufqN5mjZ/gGc5bYc/NIk73QvsE1vaJX+HVqznZT3Ani+EF7YEX
 KC0WgoS9ToYNfpUJrg7a6CLq7dI6UQp0q76ycmldqVBxXt/Cqijl8Hi5SR+dalan+PKqga9LhCA
 a5bSZCwOF0b0/41scgUvkARZ/GLR32nOsVBYs4MAHo1yKEG4+oItBfM3B/Y+5Y+yBPQKGzKRH18
 tiqVY2l3exTJfl/e2tF/RLMS1eE0BGX0tXtSj16DFs2AU/gGeksMa7PvYXfh7hTTIi8FvdheMYu
 hM9fKAloj3DGzxSYDkPkUCOK36J/Iq8y8geUjj07gX604nGfOyPn/XmkWcKEIaruAVTbXyNPwUa
 J3Sw+oyqth4mVugthSLOANgGuFlE9CH045zPINVvCOXA/ftOObQtkIuepnnB97S6tra9hd831ex
 4Iom/S77IVmAJfCYCqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180231

On Sat, 18 Jul 2026 18:22:36 +0000
Babanpreet Singh <bbnpreetsingh@gmail.com> wrote:

> ad3552r_hs_show_data_source_avail() formats the available data source
> names into a 128-byte stack buffer, but bounds each scnprintf() with
> PAGE_SIZE instead of the buffer size, so the bound does not protect
> the destination at all.
> 
> This cannot overflow today - dbgfs_attr_source[] has two entries,
> "normal" and "ramp-16bit", 18 bytes formatted - but the bound stops
> protecting the stack the day the table grows. Use sizeof(buf) so the
> bound matches the destination.
> 
> Found by smatch:
> 
>   drivers/iio/dac/ad3552r-hs.c:593 ad3552r_hs_show_data_source_avail()
>   error: scnprintf() 'buf[len]' too small (128 vs 4096)
> 
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> v3:
>  - Return to the v1 fix: bound scnprintf() with sizeof(buf) instead
>    of switching to sysfs_emit_at(). As Andy noticed in the v2 review,
>    this is a custom debugfs read handler formatting a kernel buffer
>    for simple_read_from_buffer(), not a sysfs show callback, so
>    sysfs_emit_at() does not apply here:
>    https://lore.kernel.org/r/als6lRi-H4DM7ra6@ashevche-desk.local
>  - Dropped Suggested-by and restored the v1 title; the diff is
>    identical to v1.
> 
> v2: https://lore.kernel.org/r/20260718044244.7-1-bbnpreetsingh@gmail.com
> v1: https://lore.kernel.org/r/20260717040024.7-1-bbnpreetsingh@gmail.com
> 
>  drivers/iio/dac/ad3552r-hs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 02a124ac4855..f865843aa439 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -590,7 +590,7 @@ static ssize_t ad3552r_hs_show_data_source_avail(struct file *f,
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(dbgfs_attr_source); i++) {
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
> +		len += scnprintf(buf + len, sizeof(buf) - len, "%s ",
>  				 dbgfs_attr_source[i]);
>  	}
>  	buf[len - 1] = '\n';
> 
> base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a

