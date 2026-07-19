Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15F5472B
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784422598; cv=none; b=hdI+wvNGgTcsJjRayaaZqVkiPCOcAIPdnqfvHff/TIbsBN15F4Q1/Td3owuzqOwjJgQWIq20T4Y9H02IA0t0yffyBCMyUsQXkXv8EiAHgNMx7mzBzqcU364n1cMDkHOOry4Kt6l0AIw0RQSw5Ic1wp+8qRBxqvguyPnF+/Va0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784422598; c=relaxed/simple;
	bh=8AsmICqxQoE74lCFS26Y1LS4UJDLaepjQPHxljpDfT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQ2z8K1prW6Na4nMT4Y2Y3BQIUCbrbBz3UB3e+eIbsBzQXZRxcht/AXTJyom5vatyVGVTaAN75mHcpOD2FKd6Y6JDI1/KYGisR40/AUWAxn4H6/Uq87NjSmMhQiAPsfZKb6yzo12sV9UV02XuzJPnjOwD86eV7kA7To6+2Yxick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RFdlY10/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dLbVWCMu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RFdlY10/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dLbVWCMu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN216j1780693
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KAVKxQOwEiOUlehkfsf44ywYmWwZDsIamImEh7rg/7I=; b=RFdlY10/Yta1Ucqr
	+k9ykWKdQ0fCarEO6KvzJxdgeen5y6+n8GNVPCUtRoPH4cHqESWN3jpXwi/39POb
	rcEyNSbodQKKbFEeV0swClt9OXvlaN5aBKFs+f057AJ88AToC98V9/nFTY2O+fay
	VfR4+k8ndu7X9OKXJckEYy/q5NMzJlW8cHdwjYt3UVpznWQozl9m3CkFfdv4ORPh
	xE6AUqiG8eUvMYmECPBII7Me3ZLo4sm+n/+fjnowRhWxz/ESja2gll3La2WYPVbQ
	MFj/Bh4jbmHuFwzfi4NdOYFCNRCmOL0inHkKtO3FYwcu5fP+vFcbCN+mS+dlZeq/
	p7WHcA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvsu80-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:56:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84842381150so15991290b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 17:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784422596; x=1785027396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KAVKxQOwEiOUlehkfsf44ywYmWwZDsIamImEh7rg/7I=;
        b=dLbVWCMuZsg3zM8it5B30xvh7LdZIyIGhGlga1RkWe+BFV7v/0jzY0ykx//hCq+/8m
         TZu0lCt9AoIVDAVvWnK1XR32zJsvMM41McNWVjNDnCVgwK9DPWxH3lTwKYASUqvnq+mA
         aan9IgOawH+B0BfRfUA//UOToQer+gDsme/JE2QaEeKUjFGguzV5ybvnraJmR71J+n74
         EsbcuhpXEesXOGd8I4UEw9uKB2S6Mls3ApcLYT0TvBSnqUaNgpPRIpEv+aNHD+OOjp3a
         qdUsZVuW/jh0IubVbW+rLbz3FfQnmDh3SSgVftwsVkXgNKJEZmDD+rIwiRoA5Cws6cu3
         pIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784422596; x=1785027396;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAVKxQOwEiOUlehkfsf44ywYmWwZDsIamImEh7rg/7I=;
        b=SN8Ftna1LKhLt/uJTPZxrA3dUwmAM7csoIg1mj/xNeDxu0e5vJfQnG+zzJ1NAvk0Wu
         I8B8qGN0VWITnuknSpCzUDwjsjZrmvGJAf9q7wXtfcNNxle0Eq/e/c5uyuPxfJOFCxIn
         +3UaI0xAQT9sV7SGFd0YypHCyDSQinGEHeO+xHPU0tj4wli9tUGfezFxHE+xJOG4N7ZO
         zXRJXpOKd7hgYxFWx8nHQznnzpB9/wh43aaUedgmA8WVDBEa/4FNlzueLxoIrAE0ByDV
         dJGluLHV/AbvREhriW9IvbDGHPTW9QsDDAZVlSoWIFfjB+/pCC2/V4nYRE1mpn8gufNY
         XoUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsMCxDw5VXFAmTGL2Uq0gT1FqK4xIiU80QSUwlVCCKFjpTspKE0sOSEevdxuddhtBOwYCyp3Izub0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCQ5EfmQJ2g8Vu7xAveLHeNuGsX7Frouc8Dmj2T1coeiVqcUX
	tFf7W9Klztbcn6dRXMp/3uMmhA5OhUUn9R7F5zy5Ousifs3WUpyY9Tsb/3Mbg3KAUPZpyrlaBD7
	I9mPOOW4/rMVjz5vUE737y0ymEuk3C+G65gwJKBHyltOtsZx5UX9+IA4h2dxeYxWnTsiNbdA=
X-Gm-Gg: AfdE7cmuTMiBvxaB+RKGQ7aadxdIS/eV8Q6+G0nF47jZMXgvxD2WL49W16uzUNYRWYY
	ZU0mVGWTtSizzEFft+JHhoWFY28rDRb5NVYY7KyuRtlNpOm0zVTslxY6MHev4aXxHMTGGbwHpCL
	7WYX0xukCe8/r1hVVnXKVbuQTGJQG1UhSmPtYSCztnXkbabVE3cAeht0NqivDR4ShTOo/cz/bc1
	/sd+1G8s8wNTsXaDQGgFp95VUaeVnM5/DEo8ekDqNFeg5IQQvDw3+GWiuuuEvNwuEJSO3fYRXG2
	Dbt99/lopw6nJvlySPhuQlko7PAtkmWw56cCmKLh0KNhEo7cNXXutHVgeTowCr/o7YDI35KtIWf
	TnTXFSSEm/7IcKEHh
X-Received: by 2002:a05:6a00:1f09:b0:845:e440:d0ca with SMTP id d2e1a72fcca58-84c292a0323mr8619722b3a.8.1784422595711;
        Sat, 18 Jul 2026 17:56:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f09:b0:845:e440:d0ca with SMTP id d2e1a72fcca58-84c292a0323mr8619703b3a.8.1784422595277;
        Sat, 18 Jul 2026 17:56:35 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcc78asm3431219b3a.23.2026.07.18.17.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 17:56:34 -0700 (PDT)
Date: Sun, 19 Jul 2026 01:56:29 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org,
        David Lechner <dlechner@baylibre.com>,
        Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/3] iio: buffer: Make IIO DMA fence release RCU-safe
Message-ID: <20260719015615.7f59bab6@jic23-huawei>
In-Reply-To: <9a25d60e-8c95-47c1-9004-0f7a2b5d5fa5@metafoo.de>
References: <20260715154245.3814378-1-lars@metafoo.de>
	<20260715154245.3814378-3-lars@metafoo.de>
	<aleyq2J6tVWYA6pC@ashevche-desk.local>
	<9a25d60e-8c95-47c1-9004-0f7a2b5d5fa5@metafoo.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Q0LXbtg9EJEsSuHsk5R8QD5_y0hKHnw_
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5c20c4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KWs__PzXyy6bbFZHvwcA:9 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAwNyBTYWx0ZWRfX0TflLJKaDITB
 meiTgirxBzjru89W54ZmC2tY8CI9pNOsZ47MfurSwHQ9uMktkZN73co6FL9E+IiMx4/N1BoZNV6
 I9Q0o5OW6ZZqqH+Xgog9F46X9Hf8HeCrBwfD/SiyN0aUkSOK/4vKO6ZE3BnWlx6MJ7yaK4PbkG7
 lpcZaEgAsMYW+cwWdbzyhIdQ+SjUW1b8ZkHeuh+sJxSR9mikkdV88mE7y1YilNBg9LS3f4V3dyF
 qYKKSUN7BAMhKiU6TjuAZ87VteE5dilk5uMMzFXDXB/mPk05S4M2HBjp5xzAxRLF4L7CjQ1ezfu
 yvn8aoigQ/JTM1wD5b8UQQrSpGAdRHo1/mG+5ciNStvJwQgTMSCtbji//bxRFj0yCNeRnRUDapM
 PeiBm5J3KzAVrygf9SwBDbbQwdBqS6DHurFV8XLD4td7Lz0lkYPIGjGMmI3cJ7+vhm9Jn78g3iB
 6YLXX/rQ1pn07ePLP/w==
X-Proofpoint-ORIG-GUID: Q0LXbtg9EJEsSuHsk5R8QD5_y0hKHnw_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAwNyBTYWx0ZWRfX07q220ylSGHa
 SLQ0zFMvKigIJsch+m5p7WYaPTFOp1eVH7MMIVG9DTvKetivGxpQqvzFTRHo3nLkDDq2P6Fz37m
 jecePDbIHBB9tnTEjZ9MNu9UfgOt8gU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190007

On Wed, 15 Jul 2026 10:21:19 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 7/15/26 9:17 AM, Andy Shevchenko wrote:
> > On Wed, Jul 15, 2026 at 08:42:45AM -0700, Lars-Peter Clausen wrote:  
> >> The `dma_fence` documentation states that if a custom release
> >> implementation is provided, the `dma_fence` object must be freed in an
> >> RCU-safe way. The current `iio_dma_fence` implementation uses `kfree()`,
> >> which might result in a use-after-free.
> >>
> >> Remove the custom `release` implementation. This makes the DMA fence core
> >> fall back to `dma_fence_free()`, which calls `kfree_rcu()` on the fence.
> >> This requires that the fence be the first member of `struct iio_dma_fence`.
> >>
> >> Using the default release method for extended DMA fence structures is a
> >> common pattern.  
> > ...
> >  
> >> +	/*
> >> +	 * Must remain the first member so the default release callback can pass
> >> +	 * the fence directly to dma_fence_free().
> >> +	 */
> >>   	struct dma_fence base;  
> > TBH, I don't like this trick. container_of() is there for a reason. Even if
> > it's the first member in the structure. Can we simply switch to RCU version?
> > Would it require big changes?
> >  
> >> -static void iio_buffer_dma_fence_release(struct dma_fence *fence)
> >> -{
> >> -	struct iio_dma_fence *iio_fence =
> >> -		container_of(fence, struct iio_dma_fence, base);
> >> -
> >> -	kfree(iio_fence);  
> > So, we can't use dma_fence_free() here, because without above guarantee it will
> > get a wrong address. Maybe (maybe!) as a quick fix this is fine, but in long
> > term can we also have a refactoring patch that drops above comment at the end?  
> 
> I also think the container_of version is cleaner, but I checked all the 
> other implementations and 18 out of the 20 dma_fence implementations use 
> this same schema of just letting the default release handle it even when 
> embedding the struct, so it seems to be the consensus that this is the 
> way to go.
> 
Another option might be to enforce it creation time. There are some
examples of this pattern like fwctl_alloc_device().  That lets all callbacks
associated with DMA fences know it is safe to assume it is the first element
but you do have to ensure everyone allocates their fence as something like

struct my_fence *fence = dma_fence_alloc(struct my_fence, dma_fence_member_name_in_my_fence);

Given this is a fix I don't mind taking current form and assuming we might
revisit the safety of this in future.

With that in mind I've queued up all 3 patches in the fixes-togreg branch
(tweaked patch 1 for link tags as suggested).  These are a little subtle
though so I'd appreciate anyone else who has time taking a look.

Jonathan
