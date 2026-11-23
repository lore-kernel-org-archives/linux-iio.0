Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452946;
	b=nNiAvzZkvUmHPNL7KOz/UFqrzUOgFRAHQxatBD3W+sCGcZ9gWiBJudj0UufCfpjan6WP
	 bjMGX4mTkQBGfhk91lNtA7gvQen6RHMRpIxjNhsJUVL/CDcVE+gr1Vb07OhqGl/T++7hR
	 Wg8qvUTmdk4lvkB89mZhegO9uyIIH1ZsIoXduCszp0Jjkga0nwCQ9KqFfukt69H78Xy6N
	 ancuKammGbxX1V8ogD+Nhzrij1/jt+OLB63NbETNHxWkeOw6asbgNa4HSliJw6IBrhalt
	 IGRGUrtIyDvkyym37KSsF0RIlEpzRW0WQjSXKDt07omQN4ZGO3+I7D8barQNclfO0SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452946;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1qBNdVRmleCS/9xhXBs6T3qz9/oqP0C4Wf+25AeKLVA=;
	b=w0ybXOOOyxapD9aEr+K04X3PlE400xZbuAtZ6zrtcOAP64SoZIL2QbDXwIaARW/8Uz1e
	 rU/V2vJ9/kfVtm5dYt6aHRm5UdKGWKsa/vdFAiiuQTaCpVn3+aZfNVbSVGKX6yhcu1lZk
	 0e2mOP+rjPpiAbNR7Fi85/GFYeRDzWanKWNwiuS33x+jqczxHcb68gxrjmDHuEkmCjNWo
	 morV9WO6p6HLgiZ0NKw9ezLi6xrvV/atRb6StWkFl00pX+V0ckaAlJdv3kNTLyoh1HyyI
	 XphueaJrXsXeza9OA1UvKeeFMt7dJ+rqRYfML41n/6kTJPcaigAlTJ5BElvvmphFxrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=AylEC5yi;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CjLZLrCo;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15674606A31A;
	Mon, 23 Nov 2026 16:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15674606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=AylEC5yi;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CjLZLrCo
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGKkip2576811;
	Mon, 23 Nov 2026 11:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=1qBNdVRmleCS/9xhXBs6T3qz9/oqP0C4Wf+25AeKLVA=; b=AylEC5y
	iKcqNBAUCEJ+azgJQZF/UynhgNbWg0iQR87M5V5dDrex9J6X0tiOxtuGKrdrXGAJ
	HeVdu8shDJ7x595h0sFEBoJPbq1X2NBvtreOGxqnw3IjBLQPH7RxGzUK9XQnERAg
	PacEyHqxILU5pPkiSD8dhosPt0o1loUkgwxjNP/yu6Tf8ECoX6k0JbjC62faz0Zj
	txxsP/ekfDuBC849qnoxzJxhWoO+J6tW0ibDz9fsnhNXAcxcKtOVOvo6HWW1syfV
	ZFhPbFwD8PH9FSmI9IXz811H56MBWtujH1yaTEO5NX2qlOmmErNWSfyLgrfDgEoZ
	Dr+lDMNxeM6Q3TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1qBNd
	VRmleCS/9xhXBs6T3qz9/oqP0C4Wf+25AeKLVA=; b=CjLZLrCoZJ2f6lKAxGZRB
	L5mwYinTJ/Bqg0mIVsyGd9BI3BsesbCE4Nswb1h8ZYxjsrXKH5e2XKXjkhIcvYrN
	rFmJ9MIiECEMSEKVLoeyd6ZocpVobvFApZRrySfpSq9/4Z+EZTGOs4ZCmID98ILF
	6yj08sVbzOwqpjC/i6+0uRl5XkqV8jMJThwRz+pbwzcl9Plvx85HljCGTuvqYeET
	vYGApcp8DxsUJeNnCV7wGMV01fplaez7+MG35iby/Wsvp7fngiLWXTdNsJJh5iyb
	oSm3f5uG3rWYES+G1GjOMr5Wr58zxXgIyPj1dY8SMSsB3cEmCHbkQSaw1/nEVN/B
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j3tgj7svp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 11:55:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6ANGtXqO054810
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Nov 2026 11:55:33 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 11:55:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 11:55:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 23 Nov 2026 11:55:32 -0500
Received: from arch.ad.analog.com ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6ANGtM4v014716;
	Mon, 23 Nov 2026 11:55:24 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<michael.hennerich@analog.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        "David Lechner" <dlechner@baylibre.com>, <linux-pwm@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Date: Mon, 23 Nov 2026 18:55:22 +0200
Message-ID: <20261123165522.336249-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <awQ9oGse6orrsCDj@monoceros>
References:
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NyBTYWx0ZWRfX4/bNuWYgr/+z
 7NF1gv/0lWZLSt2mQqsGRMOCylvRzWlA8JLJB/jJozkOMzAbwirf4ssA1YvawVFXDamCbUnrPIE
 zSecD4jQk5k82E44S3qsf4012shcuA0fbc5M+C1FvQUpZ799E7lzKrIArKSW3jOPGcvyZ+9LHJK
 WQ91XWsAnIeYyRE2Fnje9ZFdst1SN7xB9nQ+0u2EY6lunwothqevL7eJjGfup4XpHdmL8QdGKZx
 V4m9jfTb2waepfGw3Hl12zQNIle3f4OhRU9s9hk/G0FegvOw8CAc7+teNUXC/NeCJcyrbsejbJf
 yADy33NlF9FTV6SvXa/di/7J4yP9gX/cJE8L3A02SGIvBJyM2XngkD1AR96rWHxWfXC49FpafUk
 3znVy4wjKGCxcOf797ydrufzdly1E4QJqgJIrieClC5fBHwRjaEc5OlabVBOPiZqaw6ujzPWzxn
 DxJFyYBDC2tQnI2JoNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NyBTYWx0ZWRfX1uRfrLgR568W
 C+K26c63a6+DZ6XZQaIgqoGdqNioFpyotTIpnEw7mwQ9rE7D6KX7UyV7odcDN4AUhmGiVqa3Ksr
 iYFCQf3E+pX2lU1GNytN0RMATfHON7zZlJuZ+LcKpbRAyA0SqGub
X-Authority-Analysis: v=2.4 cv=Yp6a1IYX c=1 sm=1 tr=0 ts=6b047006 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=JS9TGsG4sIu_sVulz24A:9
X-Proofpoint-GUID: LiqEW70CrUJ8u8xmuh4tUZP03vDFF5uz
X-Proofpoint-ORIG-GUID: LiqEW70CrUJ8u8xmuh4tUZP03vDFF5uz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230067

Hi Uwe,

Thanks for the review.

The driver has to know the clock rate the PWMs run from. CNV and the CLK
gate are one burst of whole clock cycles after each conversion, and I have
to place the end of the burst relative to the next CNV. The gate has to pass
exactly the number of clock pulses the ADC shifts out, so I need the exact
number of clock pulses in the window to place its edges.

The existing rounding functions give me the rounded nanoseconds, but not how
many clock cycles that is. For example, 4 pulses of a 120 MHz clock last
33.3 ns, so 33 ns is rounded down to 3 cycles and only 34 to 41 ns give
exactly 4. At 100 MHz the range for 4 cycles is 40 to 49 ns. If the driver
doesn't know the rate, it can't pick a number in the right window, and would
either run into the next conversion or corrupt the data with a shift.

In v1 I took the rate from a clocks property on the ADC node, as
adi,ad7625.yaml does. Conor objected to it:

https://lore.kernel.org/all/20261102-pursuant-collide-4246c955efef@spud/

  Then modify the PWM API to get the information that you need, you should
  not be constructing fake relationships in your devicetree to work around
  limitations of some subsystem's interface. If you need the information
  from a PWM provider for what the minimum period or duty cycle step it can
  provide is so that you can use the waveform API correctly, then add that.

That is why v2 dropped the clocks property and added the step API. You now
say the API is not the way to go, which leaves me with:

 a) the clocks property on the ADC node, which Conor didn't want, or
 b) an API that gives the consumer the step of the PWM, which you don't
    want in this form.

If you prefer a), could you and Conor agree on it, so that I don't change
the binding back and forth? If you prefer b), I can rework it to be
hardware independent, but I'd need to know what it should look like.

Thanks,
Daniel
