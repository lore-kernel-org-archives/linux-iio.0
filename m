Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C7134CF
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514705; cv=none; b=W6G3I0vU8XQ6/U1VtuQh7P76Idu+0S8UjGPXsmZTlKblQpvXoa9VQgrn4VBYG/WvRa+95p1WKVccNnZapOydHOJyzV6UMw1lsHBhJwsdAt/EMmaCjWg4YPnxZrQ5REuYs8Cd1E4sn1WeDPf1Vuvuc/265woUslw+7PvLaE9PBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514705; c=relaxed/simple;
	bh=S97BouwdViK9gkakgh9BgRgi+PQ6a6c7nm5E3R6cHtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMi4GGpbxlH09j2NdVv0CZzoXzTSe3HU7sNvADWeo8xCzwod0Oowrxf7dBfukKdE/zz3iNR9XmsNUnOrJ4QZVRSsK8yW3RS1W+Od1thEPqOS+4D8EiiM+nSLUwffubWtvYYqiGkSgOwFN9j2zBOk9xEEIXfAEVqAS8kqiRTEXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P9IvDKWI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PnPUfDa5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P9IvDKWI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PnPUfDa5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNsBpU803437
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QlNHo5iYzVa1RGNXp/CMrsX9uhHK1hq87Clnhtf7Ni8=; b=P9IvDKWID+LsL1KZ
	PS5DEWcFp7iMM7h3H/O3oHl70Cxwb9Xa26izY9yzTzgTnB1kcJpDbW81S4d5kjnZ
	bos6FeBye/3Lm7x2VR0IuDq/l/3SprQjdkovx/42TK5JVO+1qHHgphMok1Cg1J6s
	WkctRGvM3/j2sSQrwZfIW4EM7VsosgfOAsQ/vT9WG6TVvS3LvfJZeHjMcuzItfA8
	xSslQHZPNgas4lbD09N8q4FWBlqKEnub+wLWwHbTVzxhr4h6FvJ9ow3IC5G5DMoI
	dRC07u595D4UyBwmpIZQRzA4T8WKr2ltNCK18kCjDQT2KiRyz5jp8jbZ73f7Pwll
	g2n1FQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04tyx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 02:31:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84842381150so17124931b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 19:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784514702; x=1785119502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QlNHo5iYzVa1RGNXp/CMrsX9uhHK1hq87Clnhtf7Ni8=;
        b=PnPUfDa5HlmBeCPo9Pa4tZKnG1xpa4cGuKDCAVE7pFNMt7ZiogBc+Zhp6ggLAD5l2x
         Jxz1TJg/1cVSq7aB1Hc2n1L4H02H3569Plwl2it5NO+Q2vh5ATa+GO2vU3AvxZb1Y0AF
         jJaE8eGPF77rsn17D73Nlw2qKOgeCFQXylM6ncXrOidm+Jyrc3ehTQA58GjpAyXATJYB
         7GhGlyhXPHTH5IC/tauzR4QinVMOtkMvDhm6JZK2g46SyWrorl0iw1IEZ223WO1ADdH8
         nFtEqs/9PiDUiUvKdRYtVYUazHfdKfl//NzqBBlzun3RGAuBjcJSe/uIv7nszwVkUYZK
         qKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784514702; x=1785119502;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlNHo5iYzVa1RGNXp/CMrsX9uhHK1hq87Clnhtf7Ni8=;
        b=MruRoVjmWcXZHmoyBwwgHm/BUu7KY4TMTheUyU35YNmirwdWX1cakckMUNQVBmgSHP
         4dKS7kGDOt+ciJRG1GOneiR5S/yZnYNM4RpFIvXo/KIJ9uh/fibI+C8xPVK44xTw2nLb
         6sK6omhrk3SCF94lst2/1YiOLVSlPxutQZzAl+NowpwYPvaxqbQmgAuRCa2a2gGgWl/h
         mOg0PrAvWHHpTJi/bZK0IitX9URhe6/oHDVbNK6UdbgHw8kamg3nFr6mFLB1OIGsXau4
         Munny0nF/ZwpD6hOKW4QiMWwK9QImoKxlFi1Ws49+qWTpsW40MjJXiPBmkG9lmh2qkbv
         /Waw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/DjFnx6OkgWoDcSAr7xuayHt3G5hKEE/wA/sednFW+mAdQ5RHs7HaVhRyFkZsrLCz9HzgnNDwkIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBaJVDbT29V1fFkbsTHGsEY01kN44r7EtX/5yZP0M/ebOe89P
	WB6BsdqWcTIO61rIWsAIqs0HfCw62sRZl8i3ybx93UolgGhK02ObLBedTq5xYNBSlXp1S90H29W
	CQxeRDdMqOuYo8gSL+iv4WdoP8I7k/V7P4rxZ6ycgmSCy7JFK7gU/LDeJRfWBTGY=
X-Gm-Gg: AfdE7cmc9AgXft0uMHQ/wmu5CftJrnsG1NxKqRqBqfivdMKLF+tq6pacZQNGx+87mHk
	eiJpge42T/LkFMvavQv39iEvCpLT6QMZ3SrL+V70dDAhjCgrsYUrCKoEB7V39ku3XHor5qM2793
	BesL5eHMFtCHh91ONjUoLFyXnZMA4EG+R9Z5qYYndCk81OP5Orzd/uwUvh6CFPD+WCh/Ccev5du
	lvXUtFMzMhbkDXyKQblvQ0pZkkteD0nyXstlep8K/pmTz2ep1ljOcV1mWnNTNbOhQSoU0CVGezY
	uLBTLFTtmPM6XEVci6G4Wl5ErUTIkq3tHe9m56b7Abx1cCbqyOBYy1QaU2XLSn1thYvoinuGgrZ
	fEBR6S6KOuFMi3O8P
X-Received: by 2002:a05:6a00:a8f:b0:848:4424:2b83 with SMTP id d2e1a72fcca58-84c2954238bmr11783428b3a.77.1784514702136;
        Sun, 19 Jul 2026 19:31:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:a8f:b0:848:4424:2b83 with SMTP id d2e1a72fcca58-84c2954238bmr11783404b3a.77.1784514701679;
        Sun, 19 Jul 2026 19:31:41 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c4b640050sm1992790b3a.45.2026.07.19.19.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 19:31:41 -0700 (PDT)
Date: Mon, 20 Jul 2026 03:31:36 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Can Peng <pengcan@kylinos.cn>, nuno.sa@analog.com,
        Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
        linux@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5446: fix OF module device table
Message-ID: <20260720033136.3da6832c@jic23-huawei>
In-Reply-To: <20260715101119.00001b6f@gmail.com>
References: <20260714091846.136278-1-pengcan@kylinos.cn>
	<20260715101119.00001b6f@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5d888f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=nRZvfCYcNNjiwVuj2ZMA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAyNCBTYWx0ZWRfX8RLM4XsnpIqn
 HfGYNl/VRM/6BqXXAV65qR/nQcCV+OxLLRj3nRAcqMnsSXnhPD+cOKT3PmsF+sMukkFIpomj4nh
 PWtN7DWetvangxpUqa55tnW1wlLKVPxx0/jaW/SmG2of6WBzloKaTIf2fIDR+gdz6y+doK+Birh
 ME6EDXVJzThLg0EmBnWtgCzfYo57Nd4plElhGaPNmh0eb73U5VexB+rPS/ljPa9HI8S3oW9V85F
 93TwckdbmQ3tnWzp2/lDxha4EzPi6Dsdy0nqajT/vpUr8jWaCfzn9Yoo18f3Zbg1oPzNLLMEcLo
 lyWV7mj/LKhiV6VjvOysX7sCoNpj15PPPnHpY0P77VH8ktQPLtOO2pryrhzzM9Hp2eWzG36ivVS
 LBBuG3sgdH45kwGUThEgpfQxs9YzZ0ZyNM2bSMJWjD2tEekHg5dqSizFw8rhk8JtlpHsZKgvZr2
 c8VZN0qULJEraTSrMaA==
X-Proofpoint-ORIG-GUID: qh79SJSw53Zw5Ji20hHwqJqcxXF6QiuX
X-Proofpoint-GUID: qh79SJSw53Zw5Ji20hHwqJqcxXF6QiuX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAyNCBTYWx0ZWRfX3Lg1jguhWS1m
 d7wRgeCBGsGC7JXHmhcRdP87NXGTuuKOU0WXCJyAqenoJOVC4bEtBcjuQZCwovSsH7suox5kKaw
 wIpdjk0Ul2Q2D5OoYe2pzpBzI5h4qC0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200024

On Wed, 15 Jul 2026 10:11:19 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 14 Jul 2026 17:18:45 +0800
> Can Peng <pengcan@kylinos.cn> wrote:
> 
> > The ad5446 I2C driver exports its OF match table with
> > MODULE_DEVICE_TABLE(OF, ...).
> > 
> > The device table type is used by modpost when generating module aliases,
> > and scripts/mod/file2alias.c matches the lowercase "of" type.  Using
> > "OF" prevents the OF table from being recognized, so no OF module alias is
> > generated for the I2C driver.
> > 
> > Use the lowercase "of" type so OF-based module autoloading works.
> > 
> > Fixes: 876d94024087 ("iio: dac: ad5446: Separate I2C/SPI into different drivers")
> > Signed-off-by: Can Peng <pengcan@kylinos.cn>
> > ---  
> 
> This needs a Cc: stable tag, perhaps Jonathan can add it when applying.
> 
> FWIW,
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks

Jonathan


