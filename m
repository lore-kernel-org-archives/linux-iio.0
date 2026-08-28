Received: from aye.cherry.relay.mailchannels.net (aye.cherry.relay.mailchannels.net [23.83.223.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB42435537
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787916624; cv=none; b=LMv8uZ7gLJ+aO+3ci5YcypBJciUxu0FWdTa96wGZVu5VcNnqGCPYrceLxOVDbcH75+FZLWqAzlQBPxqXksLZJ97ppjgGfXsB6zcXKjxWX/e3lkOWFLCm5QrCpQnHQ+00nPGF7GRglu8K/l0iSw3g5odUtUjC6nF00jiiiOcX50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787916624; c=relaxed/simple;
	bh=JaouZ2JFyD6mM5cLBRbJpXpzUQ6r1jPNxEQkP+RtYJ4=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=ZduYHvEQ0X6IJmyIaHBuAO2KOv9aQvkZQJxUmXSmamsgLvvrV/YY1aHxyt9qXdcv3G86nYFibJgyacmrr05kOsyKGvAloi+SyiiSMhLtAoAllJXcL+T+axn+PNpUlmy3koCMQyepUhir0yLhoaU/5LJIRaGMojGdbARvbNa/KCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kamsoft.co; spf=pass smtp.mailfrom=kamsoft.co; dkim=pass (2048-bit key) header.d=kamsoft.co header.i=@kamsoft.co header.b=uXvu64NR; arc=none smtp.client-ip=23.83.223.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kamsoft.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kamsoft.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kamsoft.co header.i=@kamsoft.co header.b="uXvu64NR"
X-Sender-Id: altushostbv|x-authuser|syed.kamal@kamsoft.co
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1E0417E0F7B
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 10:14:47 +0000 (UTC)
Received: from brand.servercompany.business (trex-green-9.trex.outbound.svc.cluster.local [100.96.233.231])
	(Authenticated sender: altushostbv)
	by relay.mailchannels.net (Postfix) with ESMTPA id 90C867E30D0
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 10:14:42 +0000 (UTC)
X-Sender-Id: altushostbv|x-authuser|syed.kamal@kamsoft.co
X-MC-Relay: Dedicated
X-MailChannels-SenderId: altushostbv|x-authuser|syed.kamal@kamsoft.co
X-MailChannels-Auth-Id: altushostbv
X-Reaction-Industry: 4e5a7ba40e066121_1787912087026_1549335611
X-MC-Loop-Signature: 1787912087026:3436913790
X-MC-Ingress-Time: 1787912087026
Received: from brand.servercompany.business (brand.servercompany.business
 [213.5.70.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.233.231 (trex/8.0.2);
	Fri, 28 Aug 2026 10:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kamsoft.co;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject
	:To:From:Reply-To:Message-ID:Sender:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3KtT+N/eXBToDN+5cWsikTbo1/dS3/appzk+JSTNkh8=; b=uXvu64NRAU8MoqE9Ogfra5SZcw
	yYIc2jd0KFhBHoXpg5DWDCB8dZrwuwSg/MRPUqntgvGE1+JcgCsZJuyn5H9XNsldLdneN6E5/MONK
	LNGvfgtQS9/J2R8Qu51WMP8VDr++s/J/3izqpHeZXC5M4HbXgNcxlF01xy6U3LiTVrKWxEdgohuiC
	2UsHwDJO8m3OcExFPNW9iAwJM6JNuaMIJHYXSVRV0QbWuu94/h+66HiORF9e1A+unmgFj7WpKx8T5
	eIlOO2NN8JT5UCLBbFDbYPIJ0EJqA2b7GPuNmd/9xhJ7nV8VmOaYYGQBOeTQrP0ZL6Dth8njjK3H0
	aT3bC6Yg==;
Received: from [185.184.171.186] (port=53220 helo=eoysrli)
	by brand.servercompany.business with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <syed.kamal@kamsoft.co>)
	id 1wztbd-0000000EOKn-15tX
	for linux-iio@vger.kernel.org;
	Fri, 28 Aug 2026 06:14:40 -0400
Message-ID: <a7dc973cc86f7b70576d248f7eba918d532ee7@kamsoft.co>
Reply-To: =?utf-8?B?0JTQsNGG0LrQviDQntC70LXQutGB0LDQvdC00YAg0K7RgNGW0LnQvtCy0Lg=?=
	=?utf-8?B?0Yc=?= <kahc@vimk.com.ua>
From: =?utf-8?B?0JTQsNGG0LrQviDQntC70LXQutGB0LDQvdC00YAg0K7RgNGW0LnQvtCy0Lg=?=
	=?utf-8?B?0Yc=?= <syed.kamal@kamsoft.co>
To: linux-iio@vger.kernel.org
Subject: =?utf-8?B?0J/RgNC+0YHQuNC80L4g0JLQsNGBINGC0LXRgNC80ZbQvdC+0LLQviDQvQ==?=
	=?utf-8?B?0LDQsdGA0LDRgtC4INC90LDRgSwg0L7RgdC60ZbQu9GM0LrQuCDQt9Cy4oCZ?=
	=?utf-8?B?0Y/Qt9C+0Log0ZbQtyDQktCw0LzQuCDQstGW0LTRgdGD0YLQvdGW0LkuIA==?=
	=?utf-8?B?IA==?=
Date: Fri, 28 Aug 2026 13:14:39 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AuthUser: syed.kamal@kamsoft.co

=D0=94=D0=BE=D0=B1=D1=80=D0=B8=D0=B9 =D0=B4=D0=B5=D0=BD=D1=8C,  =D0=BC=D0=
=B8 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D0=BC=D0=BE =D0=B4=D0=BE=D0=B4=D0=
=B7=D0=B2=D0=BE=D0=BD=D0=B8=D1=82=D0=B8=D1=81=D1=8F =D0=B4=D0=BE =D0=92=D0=
=B0=D1=81, =D1=82=D0=BE=D0=BC=D1=83 =D0=BF=D1=80=D0=BE=D1=88=D1=83 =D0=9D=
=D0=95=D0=92=D0=86=D0=94=D0=9A=D0=9B=D0=90=D0=94=D0=9D=D0=9E =D0=BF=D0=B5=
=D1=80=D0=B5=D0=B4=D0=B7=D0=B2=D0=BE=D0=BD=D0=B8=D1=82=D0=B8 =D0=BC=D0=B5=
=D0=BD=D1=96 =D0=B7=D0=B0 =D0=BD=D0=BE=D0=BC=D0=B5=D1=80=D0=BE=D0=BC (073=
) 641-73-44.

=D0=97 =D0=BF=D0=BE=D0=B2=D0=B0=D0=B3=D0=BE=D1=8E,
=D0=9F=D0=BE=D0=BD=D0=BE=D0=BC=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=92=
=D1=96=D1=82=D0=B0=D0=BB=D1=96=D0=B9 =D0=9E=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=
=D0=BD=D0=B4=D1=80=D0=BE=D0=B2=D0=B8=D1=87
(067) 995-08-92
(073) 641-73-44



