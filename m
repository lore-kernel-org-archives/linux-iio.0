Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F0937B407
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295376; cv=none; b=AMQCl2Czf5d0umxrinXK0DDPMGyYtq1diL8+F7TdD8sykBEfHYDUzITLbQrIuMVouL8w3PQcZV4KLK28VYqHskZ87paRuu33KqhW8BQpGCE4x1g8pAKeJtutEtm6M7knbMzD56ngTd2IVoad5KeLJbBwy9XGW09ukTXvmjpI3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295376; c=relaxed/simple;
	bh=7vgtzD9BQ48niWcSvjgkW6oNLh3IjoSCUB8nqqKKFXc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nMLG7LstnwLyIW6sZVIv++mIzF755JxjfRbTHhLVK2Fa1s/1tJjhpMcmULCYbt4yB7MhGBXvkjjUHah5gG2g6e2toPD7gGhf9x+XTBU6lobhRXGnaPDJ7xFnkKJHs/pA+o5s7o7q8DMZnoKn6E1ZT2tgyMrez3oVxlCJgQJBq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am7SMz6a; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am7SMz6a"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab46931cf1so26203455ad.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 19:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778295374; x=1778900174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6866R8amqJxla4MgcLS3O6o3R5zb0GhWrUGc5mXMT/w=;
        b=am7SMz6aG3QbCcRb6Ku5YbZAMws08Wo+xKqzw3oq9UcluQ8h8kES5aWFE8vQRJ8NhU
         kS8LDu/aLa5f7lHI39OyCD/LBSwnEJi3KZfEzZgGIEEAJBrmnEGIdn2hU0Cg9JhP3vtJ
         iSKZxPcP8aMntt5Daz3xV2xwvTojWtxOMlmA0glCtm910/4RCwQlRjsPTG1fOV6fJ+ji
         D6iGmYot/Ffm+DYLbjOb8rGjHTBHURVRrFyenjgj5Iu2NpPbbw2HIGG0VLZ+VQKcMXB2
         GL1XGanJS6edaOD8iahQcbSm20GK/MThAmUkPWpG0Nsnz2NzENbJAg/ZVxkyKATGVsNv
         wMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778295374; x=1778900174;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6866R8amqJxla4MgcLS3O6o3R5zb0GhWrUGc5mXMT/w=;
        b=SOkbcB4BNQTOXuOj7R1VOMRKNfoyiJRGK8IlvEdcxpMdufTeFMdNxXEJsnMcM1tmgM
         eypng6jmTGYZ0Zqrsx4EJeJmNn4spdkXj6/e0gC6xgjiY3+E7wIr2fTM8NO/kNtjBP6y
         c3F8OlkuOtRNq291DbmyilBdMj+peRdNL2BL82gPHzhs0KWL7SgwsWwiqkh6A8RAcgpv
         FsRML6L4bkAg7ny64WTRnOkJFHFUiU+RKFxNbZJnxgl8+8uPw7aMY6tII/yFH4etBDtn
         6yoZezThDDQFNePkc8P0tRi/8eAu6devxgXGRn4VRiGCPigkQHMldJDVr6sV8t2CfleN
         ToAw==
X-Forwarded-Encrypted: i=1; AFNElJ/QZmyIwJbd4G64G1pEfkG9BGDQEp7VAdI+Km2U1GPcC0+J6a5auegSliS012NB2SKYB3Jlx+FJhfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72FKt3wjETaCosSyzVwBzijKQDS1hDXAy/ODzyDYkZpymnvEe
	vxYVnaldQMNkO5pVJst83Iz5uiwdGyEqNDjXpWK3wbIw/YF5+NggoFwI
X-Gm-Gg: Acq92OHLFGffOhJVz8D6Q4Vqip/5mtdULhrBpK2/2Xr96Ppw7VgazQO99U2Rkup4Vi9
	5Fa3hSbowRAy56CjejDF1v1doXepCsruGgT8CYaJTW7Nni1DJqbKmqDCg0oaV5TImCEUZWAk4vV
	450eSYRhMc2KfThD8A/Gxcrw3Ai5CLrP/Ku5Ox8ijna/QYnKh/+5dejhTVG3cYjf+6U0COWABQw
	YmEniGjv2z+gVQBMtQN0pKpKm7mJoPw2cAq9ngyoZLOlCOmWyvtz7LPkoJ4KTDTVwtY+U6HIZAj
	Y8V+bP7nHhNt0F742Hf9tCIYUov1VVyBy6SuoS7Q6z5Ip3+10sSbMxdCssPgv/5ZPAGvP+ebdNC
	7teRbBmTQY75mVOpuglfZW9JYxhFPyHaiYfBBBJDIa/vGiVLzs/UrKhl8ErR3QuvN9D+ps4T4NZ
	nQ98Bsfx+OtQ29sPYducZR/fkvWy3N/i+pbyBwrtGRW+UcDWY=
X-Received: by 2002:a17:903:1103:b0:2b0:b258:2a57 with SMTP id d9443c01a7336-2babd60f239mr97861905ad.27.1778295374295;
        Fri, 08 May 2026 19:56:14 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:791b:cfa1:9b60:879e:786b:b8d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm37316815ad.1.2026.05.08.19.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 19:56:13 -0700 (PDT)
Date: Sat, 09 May 2026 08:13:42 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Maxwell Doose <m32285159@gmail.com>, jic23@kernel.org
CC: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_iio=3A_chemical=3A_scd30=3A_Cleanu?=
 =?US-ASCII?Q?p_initializations_in_scd30=5Ffloat=5Fto=5Ffp=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260508225501.86448-1-m32285159@gmail.com>
References: <20260508225501.86448-1-m32285159@gmail.com>
Message-ID: <8F49F478-AAA8-4AE8-B6BC-BF3C3923AAD7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 9 May 2026 4:25:00=E2=80=AFam IST, Maxwell Doose <m32285159@gmail=2Ecom=
> wrote:
>The current variable declaration and initializations are barely readable
>and use comma separations across multiple lines=2E Refactor the
>initializations so that mantissa and exp have separate declarations and
>sign gets initialized later=2E
>
>Signed-off-by: Maxwell Doose <m32285159@gmail=2Ecom>
>---
> ps:
> Hi Jonathan, I noticed a potential divide-by-zero bug on line 241 in
> scd30_read_raw(), where the value of tmp is dictated by hardware=2E
> If the scd30_command_read() call on line 236 assigns 0 to tmp, then
> when we run:
> *val2 =3D 1000000000 / tmp;
> we'll get a divide-by-zero=2E Will send a patch for this later=2E
>
> best regards,
> max
>=20
> drivers/iio/chemical/scd30_core=2Ec | 13 +++++++++----
> 1 file changed, 9 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/iio/chemical/scd30_core=2Ec b/drivers/iio/chemical/s=
cd30_core=2Ec
>index a665fcb78806=2E=2Ebe8c055be184 100644
>--- a/drivers/iio/chemical/scd30_core=2Ec
>+++ b/drivers/iio/chemical/scd30_core=2Ec
>@@ -89,10 +89,15 @@ static int scd30_reset(struct scd30_state *state)
> /* simplified float to fixed point conversion with a scaling factor of 0=
=2E01 */
> static int scd30_float_to_fp(int float32)
> {
>-	int fraction, shift,
>-	    mantissa =3D float32 & GENMASK(22, 0),
>-	    sign =3D (float32 & BIT(31)) ? -1 : 1,
>-	    exp =3D (float32 & ~BIT(31)) >> 23;
>+	int fraction, shift, sign;
>+	int mantissa =3D float32 & GENMASK(22, 0);
>+	int exp =3D (float32 & ~BIT(31)) >> 23;
>+
>+	/* Determine sign of received float based on IEEE 754 standard */

>+	if (float32 & BIT(31))
>+		sign =3D -1;
>+	else
>+		sign =3D 1;
Hi,

Thank you for the refactor change=2E

The previous version was more compact and readable=2E Splitting the variab=
le declarations and expanding the sign assignment into an if/else block doe=
s not improve clarity significantly=2E

You can keep it simpler like:

sign =3D (float32 & BIT(31)) ? -1 : 1;

The IEEE 754 representation is already implicit from the bit manipulation,=
 so additional comment is probably unnecessary=2E

Thanks, Sanjay
>
> 	/* special case 0 */
> 	if (!exp && !mantissa)
>--
>2=2E54=2E0
>
