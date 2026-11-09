Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243402;
	b=rY1NBYrYd/lxFcoU7ZdpJ+Wpalmf7WcEFOrBZBdzzPE/tutMYjxs9nzmfWqw42V9MaIl
	 z28//Eife611lmDhJU6p9/HsBcGNb1Y8RhQ3kh90gh7fISAb1owK49IoRghG6+L/kaZdl
	 39tLXdNR6YrAzSP9MeSjZ9LnAGyKUXoSDH23egY/ln8EZmNTGRZmrrruMXxuA6YmQ9RCi
	 K4dnKC82kKy78oSBpZSvc8zekFD6d8NNbXMSCERKdF2Zl5Hdze/jAUKzo4ukA19fNck+X
	 31T7jgCa/z7slM0U3zLPC4aBdel3V0KEayX/dvbicBip9385XxQloZJd1Amr4NNEvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243402;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yauKVO7Mcq33xvKK2XhuFeMRUndl36W/Mc6U35zgzp4=;
	b=XpWYpwjS5U+ZO6uJ/YvoVDQ1z6YBtJU7LO+ha2gnW/fi5vRYa0nKtffXQlnPAwESaBeu
	 SzWyVG43RzTMNNIgHddA2fxe7rq/2rNn8WOlvmSeSjhj4DROBFtvUF125EKYir26kQJFy
	 sFsOgIgz0Y1j4DkU60OK4Moy8tchFb4+bv6vX3Cp03H8AI0d8wrENTeRhuN14xnY0Pt3V
	 PuG6QuriGiYGPqgTMq3ebjEZaTpk9/rKUAtji/EAeER3ry0uDn5kZJGdLfn7GRbty6EPW
	 uy4NzGa5Jd1YUR8u40vGkbcnmxWlUrhGAQ+3unPu+haUnjENMypMCyllRSnKU63beNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QiJBIw2O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MT4z5lWm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B4606A321
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B1B4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QiJBIw2O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MT4z5lWm
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DEpLW1322920
	for <linux-iio@vger.kernel.org>; Mon, 9 Nov 2026 16:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yauKVO7Mcq33xvKK2XhuFeMRUndl36W/Mc6U35zgzp4=; b=QiJBIw2OU6JQAqiU
	IMu7SnKDA3OftsxroKU651JnYMXGvtAhKqm8lUqV0hVVp2hmPU+q3i7f4whlRUOI
	YvXg0QOnXhc1K0yOU9bv/Nf4HdUaNhfkLLHcPby1SbLnuhDDmiI5pVL5PyTUeasK
	FW7r1WYSgOdB4oWTkMkr2hIhZAwpll5EwmvR5vAMR2HzXJVtRPlp4cpKjYfo6J8r
	R0qGYD2TqVshl+5jyoMe+i6MDxYo90oARsbOFp1m9Uct8s+ME+zWk93rZbrKOB4S
	saWCw/K9sLLsdDIYM/6lYwQeSQlLG/qAOFQoYh0pZjZpRXYo2P/6Qk/MCB+QCONL
	qOYkwA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qs0fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 16:56:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd652c0385bso647923a12.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794243401; x=1794848201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yauKVO7Mcq33xvKK2XhuFeMRUndl36W/Mc6U35zgzp4=;
        b=MT4z5lWmR0DsHtst152koLdxtSSi3Sn1/hxACAwZIt4vqcahn/YmTL2Uh+qj13SBQW
         Q+7G/MFlpMZRikj4yFrdRO8SXgoBeCjNJ+2xibL6xCKX3joQW4EtPoUD6FINndrHISXd
         6p0z8Oyh/tPRa/OAaB8vCEYLiagtCaEqx/OF3ouYDPM87xXVVSke49vo0KmAKtw6Qyxa
         AIylDNwBNYyne5eXuLnGQj/axsi2Fi1goj4nFVAsyrd1hep4KlzYXYT96vs9qHR3gles
         kd+pBiJUyQ7U0tMG0BOU7Ib19n4+xkIUyipvghNMCKTWsWy3TTm78HW6AJ9ixwILeF7v
         C87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243401; x=1794848201;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yauKVO7Mcq33xvKK2XhuFeMRUndl36W/Mc6U35zgzp4=;
        b=2UIHMAHx+EZaQQIrVJBZ6f7lYd08BlhIiUEXQfmoInbeTL/IaCuBv7i22cXoLA4z/U
         Udfsn8DpWsHn0kiVSxLa0UdbBnlPq1bFKYFaYCVM8RNmhzWb5SMXcMFNgWyA40mRQBnH
         fpdUQOizG3KbNmBeOwQ3GuGR9VwW+CKOv5x0oFwZKMyZEZLaSNN2oQ6MoJjg/VgwoaKl
         38ejzfVimAlIEq3Qy86D+VTVkx1B5vq/cZVDeYHo3KaXeolsqrk4Scb6Mcj1uE3fKsoA
         11fd0crhfxdpW/O7wViDTiUIDWPMuEtSCvN0X8DVmh+b2m51R3RfXaojD0ETIexpAHFB
         JvNg==
X-Forwarded-Encrypted: i=1; AL+hErFwfRzB3zdvqiF+iZFQNu003kgxjcrm5Y5yxe7otf7foGkM+j3CRi8TfZNmJ5Kl2FQVaKGNOZY4JJ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z94If7BbVLtsclBlu8tPkBGjLspS1e4sf4dFoIIx9oXQ+V1/bQk
	uRAr4JlIBs6TyXiCA4J3tP7fA+scbIu4mgFuH/PIJIgJfnPc2g+50Lqk8ouuYOJinVc12Yf+NO2
	MOHAESy5D/jDSKmgfgnHWcGMej9C5V+vrCgCLzQFWL1465WignfHkiewbKZllNvY=
X-Gm-Gg: AYBFou1o9HArh9LbHkOjHjVBoStM7EEY8entuUYgEeK4ifrmdSUczSwyrI2PwhRUlzC
	gV6Po0YpHu+z+tayPBZAkZKf6BeAqloTJ/b7r8Cl5SJwgTETAT+hu2RyH+UhWKY0xDF10byU4AE
	BtHUlBrpzico5V7o/neC/jvOiJJziZCjUWB4CtMNSSI8ya4A0/NUNRrQJuTnqtOzybfQ4dnZTrJ
	dGR3O1tCSryyQvVbZTF7CiouEP8xs6R4yvpq+jmlKQnmmCzLzHGWkli0gqW+KDQ5a/0TvnvP53A
	Xgg/PVWsDaK5hG7b+RPUVf33Y0m56qU6lGa96XbDUcOoxALspZ7C0mfzFwo4xvjU8yNJVHDH1kS
	VdjpZ69Jardfp1dMQ6hPs88uzh1hlyjuImV4KrR2/Zf5u8EG7AjQ6MNQz5sY4S2JCh1IS8eeqW2
	Oa5vRRS4l3CGaFABucbWSdOv9xHQ==
X-Received: by 2002:a05:6a21:908f:b0:3eb:a104:f30a with SMTP id adf61e73a8af0-3eed202212cmr5000501637.12.1794243400715;
        Mon, 09 Nov 2026 08:56:40 -0800 (PST)
X-Received: by 2002:a05:6a21:908f:b0:3eb:a104:f30a with SMTP id adf61e73a8af0-3eed202212cmr5000479637.12.1794243400209;
        Mon, 09 Nov 2026 08:56:40 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b64933fa2bsm1688177b3a.21.2026.11.09.08.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:56:39 -0800 (PST)
Date: Mon, 9 Nov 2026 08:56:31 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Per-Daniel Olsson <perdaniel.olsson@axis.com>,
        Kurt Borja
 <kuurtb@gmail.com>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
 <andy@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: opt4060: fix inverted own trigger check
Message-ID: <20261109085631.00007485@oss.qualcomm.com>
In-Reply-To: <avHsKUE4xJ0vdu6P@nsa>
References: <20261109024746.1253593-1-jic23@kernel.org>
	<avHsKUE4xJ0vdu6P@nsa>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfXzIy4lNlpre6T
 uN9mynFguxjizdjKiHygv55gMVJFSnnsxzZvmv/xYTnAYVXqx+KI0cOlm6UyMEzOmqxSujKmCHr
 gNcs+JonOsyIatv63qkJtd7qxDx1hK38OFY1xQOjqKelF1+qC3s58tVikDQqK7F3IGQP+C5LiFU
 8vRTE4S6vTRqzhIL9nNqwFmvxFPjsTbp73FxITwqVENY8kWyErg/goA+GsYKN04UzVJmNlhVCzt
 91BgmWPjg4+flZ8TpcBtiyUmkor9ndCPg3+cpI2D5A+LQgtRSmFmmaD2+LVrmuIuLlB5Buz/Uzq
 dROFjDRX7//D3eXd1NSY58uhlGcuKVcfiewDCkW0z8dHD8aOqiQBHR48J0ccPwSQm77khuIgGAi
 0s+FCtZHZXq6Ez3UprbVczFKVobXeiyC1mMd26sxJfFJ8iaNaT/YBpXVJhpBsYqJLgXP66iO/aB
 hXBYcCDHzifkWVeQbFw==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af1fb49 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Yv6QgJ3ExnuNNy9BQ7QA:9
 a=wPNLvfGTeEIA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: iYBpu4O7JGh-34gyZ2uCLsin7nCDYjtk
X-Proofpoint-ORIG-GUID: iYBpu4O7JGh-34gyZ2uCLsin7nCDYjtk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfX8FM6sfICycp8
 sgdDQ3HHVpPyqDWGbt4C3LYmtwsyhK3OYvdM7ET7ssu6Pr8G75+l0OaoE4vol/BFigmpXxrnxy6
 GDEm7ZZLxhuImEydzDNBcNImfW3ca9Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090067

On Mon, 9 Nov 2026 15:52:31 +0000
Nuno S=E1 <nuno.sa@analog.com> wrote:

> On Mon, Nov 09, 2026 at 02:47:45AM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> >=20
> > opt4060_set_driver_state() is meant to keep sampling and the interrupt
> > on every conversion enabled while the buffer is in use with the
> > driver's own trigger, as that interrupt is what fires the trigger.
> >=20
> > When converted to use IIO_DEV_GUARD_CURRENT_MODE() the negation of
> > iio_trigger_validate_own_device(), which returns 0 for the device's own
> > trigger, was lost. As a result, with the driver's own trigger in use,
> > enabling or disabling a threshold event switches the interrupt to
> > thresholds only and buffered capture stops. With another trigger in
> > use, the one shot conversions requested by opt4060_trigger_new_samples()
> > are instead forced to continuous mode.
> >=20
> > Restore the negation so the code matches the comment above it.
> >=20
> > Fixes: 8284a4985416 ("iio: light: opt4060: Use IIO cleanup helpers")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > ---
> > This was found by an LLM whilst doing a refactor of related code.
> > Indeed seems there was a change of behavior in the sited patch that
> > wasn't as intended.
> > --- =20
>=20
> Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

Fixed the linux-iio address.  I'll probably post a v2 so I can pick these up
as normal though.=20

Thanks for the review Nuno,

J

>=20
> >  drivers/iio/light/opt4060.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> > index 8253a6a8bee4..1a7d429453be 100644
> > --- a/drivers/iio/light/opt4060.c
> > +++ b/drivers/iio/light/opt4060.c
> > @@ -310,7 +310,7 @@ static int opt4060_set_driver_state(struct iio_dev =
*indio_dev,
> >  	 * IRQ and sampling must go to or remain continuous.
> >  	 */
> >  	if (iio_buffer_enabled(indio_dev) &&
> > -	    iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> > +	    !iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> >  		return opt4060_set_state_common(chip, true, true);
> > =20
> >  	/*
> > --=20
> > 2.56.0
> >  =20

