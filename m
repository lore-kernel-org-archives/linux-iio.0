Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794475935;
	b=QrzsR85Mtm51jv0dtYiHHH5UJX9xO7gCwOKuCorbzAquKCV/Zdeukg9xW2djS78u44H5
	 PrHwjTuAARJuPQ4e4pX3CaNOj6YD4MkhKWtdtiljVn+xIBQvL2hDufZpQ0wojuycH+h0w
	 YHXX6eGpax1btli6i7Kms1Pl9K23y/JqdMizVG2u2kAh8cgSqH8BaFeFvA7G3Of6SY+rg
	 NGKRHUt3Vc+vaGzSrmBPlbRWQIdpF2rNKeFwBy7kMneBS3h29TEHsS/pR3Mym9tvePt2v
	 ESbTQKGn4bfyIv7CWuEp8e9Fo0QIKV8GWDRR0Z1w2n2xZOKWsxwzam/9XJYvM4PeIDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rtcQGxtUUhhpjG057YI1ec0swZMNCA7K0pNp77UPUn4=;
	b=x+KF/n06Qy7rVjhS3vGjaI2sSY+rmQAF8JK+KJnBCr+TaGuFc1Ek2qHMQF8FrlnnM8am
	 /J7CkdfFaAtM0PI5xT5oTiRrexl0wq1aPqZSm1DsiaPvrreQR6YWoyOy0z9z555BwUdvj
	 Pqui/95KGiAQ17N+RHlioksqBCUxtyFKSuyP5zspVfepGSstYJe9nYPOnFE5P9zckvORA
	 FYEXw4q0x9mowhpGv1IV+9y6iuj0ZXA+G3V0858MLdYrpBip/rIBAyG7HxvlEbw47NX9I
	 uoYqN0an4guh+SQQ4emSLqwct3JlUg18LvoCkLWiR3PnOqMLFFKWUB/29s4ZlstTrTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=la8x6vRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5C606A32D
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 09:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BE5C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=la8x6vRz
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b1afdf5196so1508058eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 01:32:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794475934; cv=none;
        d=google.com; s=arc-20260327;
        b=YwC3o/5fGEeu9bwDzcA3Ub7pbKrSkJ8n7EcS5PU1BCNEURhritrnmiSgL65jPnDbIj
         W8uOt2MHtjq/XnbTchTKAVDpGrMOLqyWhlMeW7bPp0VsAMe5wZPCKjI3JZ32Ujf++Jn9
         Wf4+0saoMyk9GsCOeHrhIqsYKVKAJmMKf61KfRCE+sn1IIct0jHq3aVXz8yH4bz5e7gl
         JFneqdXDdIHeJnzA0GvHi3a0O/bUvOSgSYefg1PG++ffN+6Wwrn/auEp3YAUbt//PP2o
         zqbBKZ9taFwlQl5l0DWgLETSgJrnrIKGraZ2QkvegBfdsYqbvr4lx1G1+qahPQaz7Ald
         wFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rtcQGxtUUhhpjG057YI1ec0swZMNCA7K0pNp77UPUn4=;
        fh=EcCXoWhFmIBIvsOMTNdT4M7njvvTiRLZUES7p1GK5nY=;
        b=SL5BAyH4D9Dm05Y3n0RKjdaPZ55DCymhbTR8E4cpsmM1cer+JzXyXt8XTye6/EedAN
         KduGyA0r9KM7LVwMT37phJFHWwGhVGuafJMclwQb6u/oyCpQJBHFzaShBIRjaikaMSTz
         yffMJto8f15krVak/sYT8xBCOY2zr0kcQtSht0OW/sCOpM56ydsjoL0BMY542e5UE8si
         dBbEv+ShKO7ZhBi/C4Mcr+iUDFQz6HGrqfu9Th0XqfcrKlTqcJ79NdpCCFGfn6mgZWRh
         cJCteCCm8rWHbNM36S1essfxjOf4gxJtinPz2lH4D1lAGagM5x3BJiH4PXzmO+jDUJKy
         fFFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794475934; x=1795080734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rtcQGxtUUhhpjG057YI1ec0swZMNCA7K0pNp77UPUn4=;
        b=la8x6vRzijxP0etMAPSWRHZoCRhkzjQCIDsH79wQNax8m/e2FfKW8cGfFVgbsiX77R
         PVIrmeR09tctHRKzXULGbF6ht4kvyQlpKS8ujksI6X6lOG3qB7Vwgjn8VCDBX8FhgTf9
         qEr4y+w0r/K6odgxKk0KUaDAP3jcr4q5NoHcf4C4QXsftHC6JKPm1YLEimxKiHIY6RGG
         3DmiuTcXX/0eB2eJS216eQAvyn/owMsvfEeCkT9OMXStiG5c/Ud32T0jel3oGylciBwJ
         YB69RYPf4MZpOvWejwTidpWO5wFGWjwrNvtjVjI/n+tWKnwP2lXt9hMeNH2k3C6hkhKT
         pH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794475934; x=1795080734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtcQGxtUUhhpjG057YI1ec0swZMNCA7K0pNp77UPUn4=;
        b=feQDbolyHXdWNoF6foYzDLA9hszZjAKR2uZiTBVkPq5MkWyrM4Iz4NGi6foFscBEaf
         VvKTwkLA54uTDIWd6O+U0iGMBpjNR+OhyF/ZwoUZ3CvGKPRk6EEB2ibOTY3g0A4Ybihf
         DjKiUlSDwHVNieHObJnt2LZy0gIR27sY/yzZFTp8qMeVqGMVT7qbx3Uk4I8YSZlGot25
         SmPei7ZuP7r1B9blq99zSEgUWzxQfJidRjdB12O36tl378Cw4jP5KzsDWye9aXPIuoBw
         9BUgMt+OVw2724rs+RUzce1S4qb79Pp1XhSBnmXM65rEPdtYuEWIPbQB1i6lXU9F8k0V
         qhew==
X-Forwarded-Encrypted: i=1; AL+hErFY7TERfV61gPTCO64BToc1uvzZe5ciIpbU0n7xAoNQ54RddG6G2fd4sRSLI7epMsGwap9XowEL4AM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rR+x0p987/w0FQkMgyhXPs+MCbHQ5iMf340s2cfiIQEH82/V+
	fImY4zWi+ZswfS8OHL5oCc+nqT15KivqMx0fVetEKGbmpsxHfgexCki1R30x6Em/6VaQ5ptq9db
	WHMjT26cA1qQSNFWZ/O9sO2/mcPpeyfk=
X-Gm-Gg: AYBFou3xfzUa8APrPaum3f8O3Cj3uSd/Px0kWDcJEi7sXkVQwB7p+PRtSbVc9i/BDkt
	bj6PkKE+yR3PXrDES0b3jE3KRydDihugc9KHI7PO0Gv9Pqal/Mrj8PnxRwEUuWRCJ0jl+96akfh
	/M1kSDzbBW6yEXnW8VwzkDls2QGvnBGnotcadFchMPzCN22ZVFTxzTVQ55w3/uM0STsF3EXhpJF
	rbTl+RvXOjM0HVRSlvyvb9+WAsXQT9b8MRfbu6BBV/ChdlJiiQpYkanB1UB6hraeMB+395+nqD8
	RPYJk1Dx1THyx1aGhYgHReBwE/vWtyIwp5F6q16IWutJHn0cMMyfSSbbzZXG672Ijl1Gu7/PlCH
	cQlIn0LQ0dbijGs9XBa2/eneq1VrVt42R5rdAKQ==
X-Received: by 2002:a05:6820:f016:b0:70d:9063:1ff3 with SMTP id
 006d021491bc7-719172c5534mr3337591eaf.0.1794475933878; Thu, 12 Nov 2026
 01:32:13 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111101345.185122-1-abdelnasserhussein11@gmail.com>
 <20261111121544.00006c23@kernel.org> <20261112022619.5693c4f9@jic23-hlaptop>
In-Reply-To: <20261112022619.5693c4f9@jic23-hlaptop>
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Date: Thu, 12 Nov 2026 11:32:02 +0200
X-Gm-Features: AclHuK9G6SS4NwCS9PaJ-OUYEnCgsYzhvEBdLrccU8KpXeI6G-aNGeVg9dQfdU0
Message-ID: <CANpqX3YF5X1_LjXvymcXPwib9koufOAFaAgd97RH8dB61bmZpQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: at91_adc: move to devm_* to fix NULL pointer deref
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, mripard@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Jonathan,

Thanks for the review. I=E2=80=99ll prepare a v4 patch series with the chan=
ges
split into three parts: the NULL check, prep cleanups, and the full
devm_* conversion addressing your comments.

Best regards,

Abdelnasser
