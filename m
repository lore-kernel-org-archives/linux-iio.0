Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243340;
	b=3TQENIa/p+8iHO32tOY0ablsjBIqH6DADIGAlxqKWZmT1KvTQK34k26tQfSzG9iMh3y4
	 LRe03UCOkekZKokPpGqwHBzLmmGLlVC38jpg+R+SovY9A2dAS5OKRQkqStQFCFWFxanlz
	 wSD01se6SNctr0o2wcEUZ2IhjxjNlgXfM46anFVZIqP34/Nx20etjL2CKSTXShH/eHaGC
	 kNMRlD3m6vvZRYq72zUOhTCMUQxmMBgfn2q3hjo2DWjzac1eQuhQ1Bmm0XY6cqX0sUDh9
	 zxMnvssnA4C2cMJ7yfZPrNEJVSyNmaDg0MANytDcY9zRIINCY/PKpuMjNWqIo7SBJUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243340;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bjV9zPSqZzSjy7az1JAePwYJ6AKs5SGK11NxPTFGx44=;
	b=cQXIE1Z4sp4f78nYtcNTTv8yQ2NkHJCrMi4imKMh7D/11qXEq+vko6H7pbyBhhvAHB8E
	 3l76szbXc+kaAuC03p/InWv1aQE8bLB41QHcoWuVcRE52gykNU08H4Yt5tGQsZmigoFS8
	 KLwntsXuopvYgR7YKUFqYWQ0H7/NnCnwDORutWhISsJ679JsuGE5QCSbH4EH39mHyNJ4B
	 78kCbbZHfxDadj9NErLDHCPLlzsH9dLZZjd7A688ScH8rXzW4jgTNnRbywcpbSIVp0oiF
	 j7XATVxVjmJzIb//urUP22fNnturPSu0pJpI2rgHhx+Nflz3ZP7tmnk+GBtau6oCukA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T2k2haY3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c9MIWa9T;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526D606A33A
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2526D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T2k2haY3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c9MIWa9T
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DF2Mv2928715
	for <linux-iio@vger.kernel.org>; Mon, 9 Nov 2026 16:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bjV9zPSqZzSjy7az1JAePwYJ6AKs5SGK11NxPTFGx44=; b=T2k2haY3g2VkEIHP
	rxOCj1QXlc7k5c2V3lG6aArRReThBv1wOBb5c7QtL9w+7CTrXzAWe/kdGVWuh+RJ
	JFfXZmEsl/6s9ZnkQ0CbUBxAcdfr6L+9NJKYZnarPJkSUZ1biPjSe41he3KO9b6v
	pIjHH4gIc21NyqPk3ySmyo4T97lVjPhUrdzUdnqP/xCjSxwbnVc7BEFKwV2LaGfu
	FBjfd4kKNhA9fBrDB7dcZuXHPUPjNmGK/l+rW8WfP+yGTh9sps5CTgYXjwtlFbm4
	dI+1mojUKjovCrCnWelwAKWko00uVWuZnb4cKid9d6hdiHmvb0/bZT5ITKtXGeNu
	T/rYDw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hubt8sgkg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 16:55:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3724667bc16so1049773eec.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794243339; x=1794848139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bjV9zPSqZzSjy7az1JAePwYJ6AKs5SGK11NxPTFGx44=;
        b=c9MIWa9TbaqaTZLBMC5VrjGXdrGKgNi6R+6f8Bp5hxdVL7h8pwC8aaeeZRDEv3iAgE
         cEbXuRimNj+FGgv/e6KzN8g+yWlKa2Lo+5tz1bB+7wIcLCta+FvYZl6A9/QZf5wvmXXH
         J586HyDW/l9mJGYzYsOsp+bcUuzLhu41ak0DAJeRilQf6E9BvyZ4BFobU8Fr7Ivqv22F
         in1XvNIrgOXSrWC+WBRKUC+WUuxUtFiQK8Inl8oxD64Q1Wnn0iTPgXlffjkeW2B/mX2E
         XVaZqg2AI7vMFiZp28gBWn92lzyxzFO/HOjvttR0JJgYvZDzV5Dyt5GVdZedm3HsPJRW
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243339; x=1794848139;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bjV9zPSqZzSjy7az1JAePwYJ6AKs5SGK11NxPTFGx44=;
        b=FCzpSNo/kMplIoKJ2hkgnBjJn1xkn/dKqUptDsbJjVxVaEgYO7bZrUByr66lfe1JpJ
         56Sy3bAraQ4+hBvqjDCIl05rkITDa1bdSPNh+FmOzvtTAi85AMpMdoeHI/bsIrRQm84L
         WUuxg6vHmb6evKfUCWJFUt2+yA5OUiS6yDPiEOns+MaA76IxD4KNGUQpnqnY/bDBtwLy
         ta7AlIZqsndJOm0Am85WhhjdjH7XeKp1q299evViGKRr9Mp6z+AZ08cr1vLiqHXMmWsL
         GVHJHUn4E0aK09RewQ8ClILFpVxF7T29rV2M5vouxLxEWMHxXbGS/vl5+TzgIT4PPhbR
         o23g==
X-Forwarded-Encrypted: i=1; AL+hErE1o30uQ8Yh3ZsgV5t18z6+Q1YWsSSOb/Gx7omcvVvjZWYhzrqTrK1eQaDky2qQ1yPdYeFA7Q3Piac=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qAIGERv2h7dXhHKtfBJf7ueUN20NPm5nEByRlmckraNislyOS
	F1tQoGXxY3R2If3PibWxv3eReTBIbUEUgsAf7tyL1nmRjgMNALBCmCwJfpuyzUEE2lZmvmcNzg9
	DFNlYOHxMrxB7j4jfQ0W8KtaH+QoZstDEEtuTRTK2qSORhh6nIXwFpjOomO4rv4M=
X-Gm-Gg: AYBFou1ljTdrZ2MRu4CaCXjkGwhwfgXGI6t9cdzN3sXKLksBCPwU7FcYH/arK6Sbkdu
	+db9qygYmawx8kM2zEZNMgyZN5/Ygk8Bip5Nnj+UBXlMF3Iau+10XkfuZW6izfJJrj3Q2AJ8hgK
	q1LIcQt/dLG4B7Jilpzd3vYik+GJOhs+ja1uoXV0Bvo3h8JKwTU4ABHgZwFpIza+Gz9rrYZW9CR
	+GagGZBCyNcLYnOe4y2K6ymySMFmssgrjadQ7OnFcJb4k+qFbhZmKtRy5I/gxmjTtiqYNbmJfNe
	g/Jp8sSm9MQldJmeqvBw2o3AxCnQ8am0Dp5kM5Zgmgq2Yl/6cp+YmUJprmVVRYFT0Mh2+n8YVNE
	O1Mz7Lk+YXFVsgPxqE6gU3+7UpIViUTALm2QWgzJwL1WxsAkrAFkzeumA97u/5AQhgIDGZogkhu
	hG1NML3CgmxICy2dYPXWrFwD9nZg==
X-Received: by 2002:a05:701b:4211:10b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b3b5e25ca2mr80087c88.10.1794243338463;
        Mon, 09 Nov 2026 08:55:38 -0800 (PST)
X-Received: by 2002:a05:701b:4211:10b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b3b5e25ca2mr80060c88.10.1794243337940;
        Mon, 09 Nov 2026 08:55:37 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890584sm323466c88.3.2026.11.09.08.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:55:37 -0800 (PST)
Date: Mon, 9 Nov 2026 08:55:23 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        David
 Lechner <dlechner@baylibre.com>,
        Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi
 <lorenzo.bianconi83@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: st_uvis25: notify the current trigger when
 done
Message-ID: <20261109085523.0000513e@oss.qualcomm.com>
In-Reply-To: <avGKjh7GOtE2tPGt@lore-desk>
References: <20261109025454.1260519-1-jic23@kernel.org>
	<avGKjh7GOtE2tPGt@lore-desk>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfX02XuK7/9J+GG
 6psZv8PG8GjClIEpgJhirL4ckeFqOopMfZ6LS08PFwhKMjatNY+5qo31T73PPMW4bWFcHrQ9WjZ
 5KAsGydloa/sESOyQ9hWQ4wq2eOeQ/KUAQ8Xr2geLZXiGC4b8SjDSnRqOb5A1rT0FJxKWb8hmvp
 vH3vJ2wFzdeM5K0SSm9XLkatsLeCF6aH/+APmQMjybJxYhSM10oLsI8mc4YUKydhUxDj1OjkWWL
 RQaAdg+1tFEfYEGQIsbDO7Lfi5+EOCuzzP2tddPRoiaTRoX42MD2Vgrq75rucI1zv0K8qr6a9la
 7c14QmLZYdpGUn/2tlFJCVkq+ZFACG+XR+BT95aWOCxvLP/ggs0dBqODecF6L05+kDKLHsubxas
 o0XIK01G0ELgQfI2e1mGjuuJhB54PwMHp7d1PeVM/fGN+81wrfE4SfTb5NJkpwBaZjOljlt7Di6
 SDyGzaJIQubHZVpZobw==
X-Proofpoint-GUID: qKce6aP7FM9iN7eqd0xZBbcsLjoIIS1e
X-Proofpoint-ORIG-GUID: qKce6aP7FM9iN7eqd0xZBbcsLjoIIS1e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfX5Zp8i6SZ5dLH
 nbz3J7+J9CPj1uc1Mv3JjY+BAqPbhZ6b8RqrUjo4xKYuvcjd4HuMEUBX6Sv8r+Q7VaXkgv/vP86
 5TuASopY5tao2+iN9b5dq6PAv4piyyw=
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6af1fb0b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bMo6kmeCR_tHdpvFHWUA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090067

On Mon, 9 Nov 2026 09:55:42 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > The trigger handler calls iio_trigger_notify_done() on the driver's own
> > trigger rather than on the trigger that is currently in use by the
> > device. The driver does not restrict which trigger may be used, so if
> > another trigger, for example an hrtimer trigger, is selected then that
> > trigger's use_count is never decremented and it stops firing after the
> > first sample. The driver's own trigger use_count also underflows,
> > preventing it from firing later.
> > 
> > Use iio_dev->trig instead.
> > 
> > Fixes: 3025c8688c1e ("iio: light: add support for UVIS25 sensor")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>  
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Given content is all still here, rather than resend immediately to fix
the linux-iio mailing list address, I've just fixed it in this reply.

Thanks Lorenzo.

> 
> > ---
> > Another LLM found one as part of refactoring how all the code around
> > triggers works.  Definitely the wrong trigger. There are lots
> > that access the right trigger via the wrong path (shortly to be
> > cleaned up), this one manages to get the wrong one in many cases!
> > ---
> >  drivers/iio/light/st_uvis25_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
> > index 94d5261b2663..5c63a68948d6 100644
> > --- a/drivers/iio/light/st_uvis25_core.c
> > +++ b/drivers/iio/light/st_uvis25_core.c
> > @@ -248,7 +248,7 @@ static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
> >  				    iio_get_time_ns(iio_dev));
> >  
> >  out:
> > -	iio_trigger_notify_done(hw->trig);
> > +	iio_trigger_notify_done(iio_dev->trig);
> >  
> >  	return IRQ_HANDLED;
> >  }
> > -- 
> > 2.56.0
> >   
> 

