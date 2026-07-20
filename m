Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3E248F57
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512235; cv=none; b=JGnDac+sDHRJZY9C5ar2bzD/144BYx6JhDat7HyTbfDIhAY47cGylZ8jMJXJW+cqI3T0kiRLbXfeq9/uqpiBmJLVX1l/gvcuKY9y8HCcElpCuzOzvI0q5WtE3oU1DMyrPJMXkTalbPjHm8dJ+MODGKHa/1OLwIMerSaEfB83APY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512235; c=relaxed/simple;
	bh=UVtNm5O8MUsdxjq06L8qHs0n/EnnGOTCL1sbKRNf4ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPDMPeeF4JdeVHl8TXbbYyUmGjgyCplRkGr3Pte0RilNId3vS+BPVyXYkBvmvYMbWN9Hyjg5NooNRtrh2jK8eChtag/cE6E2lHaLonS1cIxeUK7osrM5GNUuSsdXtW3Z4c2u/5xtp7QVuPyjco7pcrUo9HFfaEqtIAHRCY2bUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSIyvq9/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fyfcUNrs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSIyvq9/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fyfcUNrs"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsPlj900093
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ckeKwUQWUkOPfSK1W4wRxG9SUsj913zzgTEblzLK4z4=; b=dSIyvq9/BOBLzPDq
	D0ih7J1L+zSWwrBwO0vDcbsL6RTVPejdAnsVb2g/f8+uQteLPFiCsNCHwGf7vHOU
	Od/S/nuPWEoaf5FJF10AZc8s8CKLzCqgsX1i9QeAZVRwzVt2Q4GGkOmOd7fswgAw
	ZW/MrL0yRi5sxEELpfgadvXFMJfug+v33pMd0yQNqy3pCFG/yeW1fmF4nOjH6xUZ
	NW5mX7MT7qV4mF35y4A2b7sJJ65v37H73ansr/FngB7aIWiJz/hdfbPawqRQJKUE
	LO5Ll6d2SKZl2gB0Jcy3xBDp+GpE8WmpwsS2DkvsUQ22ndla13FXTnFNak4vYDHf
	V80T7A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnkxbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 01:50:33 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8482b95574dso12441312b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 18:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784512233; x=1785117033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ckeKwUQWUkOPfSK1W4wRxG9SUsj913zzgTEblzLK4z4=;
        b=fyfcUNrsKMCdpDLE7ujBr5bQrQrV3pgOsOMAtVnSODkILJiVzEhl+qFDJIlKCpAEDk
         QE3tAzz9b0BZYJksjG9ae9zBQ00YfyWuFwRekgUZ/PQyHukGpOBJTmCSHD8Q/jhyGhtO
         k63kVAo8KoqXyXgm9xtp3y0BGqOUVeskQCvwNpec+pbeBR7GUMkWPMkNIZpWTKA7Z7Br
         dpFcx4DLp6iymEibulGBN2OAqZXSh0ysRbWKDMB/olCWcv5d11E6NscKfB/8ySnUs6eI
         eO6PIN1tgkd+HMZN1AH292/jj3qnhHZx3wDEFb5palhyDLEz0RcGZxvVMG+FdlR/D1a8
         4HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784512233; x=1785117033;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckeKwUQWUkOPfSK1W4wRxG9SUsj913zzgTEblzLK4z4=;
        b=D2xxmObvK9ZUMVmz781moW0e/qSYu9f/N2k4FDegzupOKUoX9jsvZP70NLg7NUkBLm
         C+W5JPHkhPilwg5/p2lmYnNqepsqiha4YYHvbKL/riOmCoBiQ7pB3k9SDkNmCxFiB4LX
         AifY7vpmbKHbzUebTRbNacl9+6EMuM7iL9X7rDDRkiTfSTEPc8fFTP9eJHJH8+Evjz3I
         ShlTLjxKr0n39lN6wXeDL9mypD/Rl54I2msM7rAHqVYOLo3mZYatI5cD0KuaIy1gwNs8
         8l55M+bNOjdGO3QwyYh8hPSzDyDOevDbVTGR5dDHcbM7+Tl//fLG+nd2vPTig8giXcZQ
         z1GA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4U9nkNCTV1rGL+T32NCNGkQ21xTLUg36ebQVfzlOfTNChARO9nRRcQeWNxg0Aa/faJYVVWr1rm00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzwidtYLgHLfWO06M1yHm8Atr5apjihhFk7/GKNXvGr1n5Koz
	Ol8GGkapbMvGq4cAkMw9yP/oqDJpy3OMib+iyEUdODvxPJY+DtyliRPm+z7O7TWpfQ1PwFyT8k1
	VP2tO/DWzjVwFuiGYp2qqzagPLrOYFg8Zb5+B3jwumHvQYIqzQtDJqEpinsOfWRm/JTy2zCY=
X-Gm-Gg: AfdE7ckq1P7Di+VCneQdGCwy/1u3BXo+WhU3ZVYpysd0wXS6OxemFIRmpPgUzZkrNez
	g7lKYzhsVhMQEnhIidCJN9owT6+CIQYkCQLhuhR2KnIIoefcOELNfFEwH/DS/OC3C7L8YgiJl8k
	MVKPunfYXdkw2E9AkQkYMGHrdqOwFlqnaq/Win4OFmKmwvXHiqgPFJ2836N2HjWvSTz+jlbSB+d
	acYDoisSKN6aRrXyQN9j01vhr/F+HtYT8OU3+E4yapoC500ypOXMDz0iiP6sza8c7L9mFGAqYpn
	i07hIk8/gpImy5EuFuaLH82cuBU4WGoDTB1F7MKFXPYkL4EC9vu7+/V8NAtUIQrznkm4tY1dW/o
	nztcM7ovUj21fZtI8
X-Received: by 2002:a05:6a00:4613:b0:846:a26:8e0b with SMTP id d2e1a72fcca58-84c29334b52mr12096217b3a.18.1784512232851;
        Sun, 19 Jul 2026 18:50:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:4613:b0:846:a26:8e0b with SMTP id d2e1a72fcca58-84c29334b52mr12096204b3a.18.1784512232348;
        Sun, 19 Jul 2026 18:50:32 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8b766sm4812647b3a.4.2026.07.19.18.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 18:50:31 -0700 (PDT)
Date: Mon, 20 Jul 2026 02:50:27 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: opt3001: split opt3001_get_processed()
 logic
Message-ID: <20260720025027.20f2083f@jic23-huawei>
In-Reply-To: <20260715100958.000046d9@gmail.com>
References: <20260714-opt3001-unwind-cleanup-v4-1-7ebea805bfac@gmail.com>
	<alZsCghbqDBF6X0d@ashevche-desk.local>
	<20260715100958.000046d9@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAxNiBTYWx0ZWRfX5vTBBuWZIjuk
 5WHs8QfW8f5U250hRilGBMPomEP4tr4gAfWPh56jTTLcXOq2x1UIp+un5V5YLT+BoG0kHhCwHzg
 muwENhlzLaifCIgdweDgI30gyODoUioCyvsDGu+zeDSNEm2uz6o0EARUcT03vM51R8ZhcnI7knj
 s5LA2cjsb6T6zWIsknJXXK32v87Cq+Kovps8rbuy0kz1ZoRDw/r0vXG4YLmUpBRuvJquiz6NsXx
 dvGFDPXrhmO79PYqBF6tQC6Tz710LCIQztVesyYoWIrCyxnZd/Xmy+8XOoubRiaEtcH8Tp94QRO
 U9yGyctGbhwMoKKJRTFbZwUCwAU1aAp8iOdIHjQsbDz/xSrcLx24Oo5RJjKnlTjPBzEdiPdwX+z
 NPwSf1OKul1nwCos1j7i1CnkF1wZrfaGfWAke+l3TMbGZ9egXHDFBT5UZ14uRAcztqpv8ssh1Zf
 7QJWtqokV7RWWsEKHMQ==
X-Proofpoint-ORIG-GUID: Ei5C7Tw30aepmenqiKIDoCHH0Gh-jqTK
X-Proofpoint-GUID: Ei5C7Tw30aepmenqiKIDoCHH0Gh-jqTK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAxNiBTYWx0ZWRfX0dkHnd+ZbN3y
 uJwWq6+xuVpmLYWdzcrNtIbwIOvzhVnMYoBDggihF4i+NWToD6o3M44YP2om48HVhIW6tnL6zQI
 99GfT8EWXNR9X5FLIfJdHZA4Asn0JhU=
X-Authority-Analysis: v=2.4 cv=deOwG3Xe c=1 sm=1 tr=0 ts=6a5d7ee9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=Q0K-1zWwED3OoaF-VZoA:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200016

On Wed, 15 Jul 2026 10:09:58 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 14 Jul 2026 20:04:10 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > -	if (ret < 0) {
> > > +	if (ret < 0)    
> > 
> > At some point consider dropping ' < 0' pieces for the i2c_smbus_write_*() cases.
> > Read cases are different, of course.


Excellent point Andy, and this case is a bit special..

> >   
> > >  		dev_err(dev, "failed to write register %02x\n",
> > >  			OPT3001_CONFIGURATION);
> > > +
> > > +	return ret;  
  
If ret could be positive then this would be letting an unexpected
positive return value escape the function.  So I've tweaked the two
cases of this pattern to if (ret) to avoid that implication.

Applied with 
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 12cfb0e58870..a948353014ac 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -337,7 +337,7 @@ static int opt3001_start_conversion(struct opt3001 *opt)
        opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SINGLE);
 
        ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
-       if (ret < 0)
+       if (ret)
                dev_err(dev, "failed to write register %02x\n",
                        OPT3001_CONFIGURATION);
 
@@ -392,7 +392,7 @@ static int opt3001_get_processed_irq(struct opt3001 *opt)
         */
        value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
        ret = i2c_smbus_write_word_swapped(client, OPT3001_LOW_LIMIT, value);
-       if (ret < 0)
+       if (ret)
                dev_err(dev, "failed to write register %02x\n",
                        OPT3001_LOW_LIMIT);
 
> >   
> 
> Even after an 8-part patch set, this driver still needs cleaning up!
> 
:)  You'd be amazed how many patches it takes to clean up some drivers
that are in 'reasonable' condition!

Jonathan


