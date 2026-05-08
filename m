Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5836355F2A
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236831; cv=pass; b=XRVBSc56kWVy9CEomtr5+ledq7kgE/3NZqkBPV47e5nnPn46F8Pl3/ZpAI81g/ORvLKm0YN7In8ld5MHFnr9xI1g0J6w+JaRaFeBBIwtm/8TBXfhKRKj6J3BitiX1FNku1DId5ZT65nGwp/glNt7S4aTfMvKTOCddOqrjNiNbJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236831; c=relaxed/simple;
	bh=fuk/ObsC/jtUmX5I0WeHPysLePWeJyTNoXNotejJxnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFQ0UwzuddMVelzW9OB3WrDjbpdrbqNdlI5oWRqLu1mygCNgXkkbPrkrS4Dy5gb4bSShlf/dOLyFan7jNyORq4szH6lVBDUnuSmodyqxNSNccd2tm5Efns02sVuOPgwRVPalPVEf58L5XMhrWSIonzGoWvxKSd4XfIXk6KJd2Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVP+PqW4; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVP+PqW4"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e5bea4045so13462911cf.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 03:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778236829; cv=none;
        d=google.com; s=arc-20240605;
        b=M/+kZemr6yhMQsf7r34YVEmpZyTANk1BxoUcwFqimMqX2h3DypdKm9b2NM6sNy3hd/
         ocf7TDq/qN/8lT/9AE9U2KONVDiOraNZJwOEdfiN5KwW+2mrovCiI8KJII9Qjhj1fEi4
         ih5V8jsP9pmgLH3AmDiG8tT5ext9ThhOIr3tsa6OIxg58HzwnN66LIZyNtjTMPN3+7tg
         rofOInYNRVSDN9JkJNN3ece6K7sOwXyK+BLd7PaYNUUXTFWEvRKpeLTZFoEFQ1d1whoe
         owLrNo+hu7FPYInTK5DQLP0M9XIJEYKhZDOeGAMRpcOvplb6FmwPHxVYgossbpykB8Gt
         lIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fuk/ObsC/jtUmX5I0WeHPysLePWeJyTNoXNotejJxnU=;
        fh=vY1g1/lOEIDyaixvtQ2y+7hI1gSwNvDE6KgrBcEwtrY=;
        b=dBmHnKUmTRTF6pKyhn5ZkA/V8nArEw2FW+kqTXfEZzJFvl65EGhGWdSvvpV0JRwPpY
         Z9/E1GtRwtf851sxdqwbhRNpYky5m4+dpGVNSffstSKprk2r4y/37+2RCdNguBHm3HQQ
         HeS83r43iGX1v+JN1+dP8mGKCNC9O+ZDD9T3+A15hvfBaEupTqK2H39WYrfSokgQz3Xn
         ArKs0YO+/t6hMR/x+LI3kjWTzpLIGA7exPHmxD/yI2w84QJPu/uUsMs+9qpUAqub4zDh
         CN1GCXj+mzewLAah5U2/uYSp91gsJCIQZM0/ri99AfclIn7NFfsgZ0Cj5gPx+vPrugHj
         z37A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236829; x=1778841629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuk/ObsC/jtUmX5I0WeHPysLePWeJyTNoXNotejJxnU=;
        b=XVP+PqW4Y+RKMWOA9FcOf737/QGkgVe+p4NsWKKS+GrcZzrufYEzxUTv6s0BQQCWNs
         iq198NGPGITOW9KYk5hWLg+U7qII7xofDPqPfm7hVJ+hrMu7kZNc0Fqe2+dnKuZ2QtK+
         txIak2OoWZ24FywHEifqQUlYdNtNk92r84a47KO0gCUlqMwRla3LIxrfzITwxvUZZ/Ai
         WfdtszKlyvVnOuZLbgiWcrPzp5M2aT1ZWrjb7WaqTXRoWZYyB7k5zDQ7aOh08SGCWDxV
         NemsKZ2/wquQVJnnftITqpfDdX+eGiewj9SsFSTJLbijPYYRJSDn2sR/lEp08FclCrdt
         86Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236829; x=1778841629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuk/ObsC/jtUmX5I0WeHPysLePWeJyTNoXNotejJxnU=;
        b=bmEFKjU676bAPw1zIv7L97qoepbtSIgoW58t0HtIJKLbjqjZoFERKXv53WXWKkQkFl
         /DxaFMnWs+3uJxqRJHsY+ooMNy6Sl/Z51VvazwYew9dT2yPrvMKGyC+V7GmQzAsly+Tk
         25mTMRSipyzU78rWdXEJoiN2C69toKxDGY2X8cNMSUjFspofhwkTOeGnblbsjeRL8P41
         Cf/S/aMvh9xppKyPnAdKbLz265kyXcif5uLDIoMUD47KQpP3GuUgKc27MCaOUeYU7ydG
         Seh5tuOuKGgw6wVAV2lLZGO9GP9PjDaCk6qlTAfAPF+wAMlc4FeKOnAKUWVxDUClDnTk
         Ti6Q==
X-Forwarded-Encrypted: i=1; AFNElJ94Am1TiMwcZcJipElvHGjBddpqJYBiOzmt18pcugYKblJq/qawV5swBvg687GMcwzplsKrWLsNGz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHb8FLJcwhm6iRiEDK8swGXQ9upm/na3/2OwVmAjXFLZQ4ISq
	6DyaHcNfDXVvFNVbifxkGJEMgRGCu7U5DYDv0ASrB0macYebDyfwAoz5d31w0kc5Sh2kOuhRptC
	vqGDxag3M7JcAHnZb2Uhql/Yq40uza/0=
X-Gm-Gg: AeBDieufFYGuLpv5+cyJigiwC6ZQLGiOVdvGw+6f9CwB6Z0j3zN0PFSJPhsGl3DWs5m
	vigRH2gy+KQW6tCtjcu4tfQRZDueixlzIOq0CszIshOj/0hS2LwPk9I9ktO43RM72L7phYqTTiO
	XxQNySKfbNIjGrv7yl6BSdMt5owxS6LLlX+RAFL0dSMiW4uJM/6NB+k8CZ9hEv0JnrGSFyoUcjo
	AOEbshDj6w/nj3PxaRvkOjWn+ePX+26lLGTeNu/NPpe7tg23hOzF+LaHNVxAMoL/owBy0I0Xio+
	cgAKWdu+tMzj+vaH
X-Received: by 2002:a05:622a:487:b0:509:379b:d4e with SMTP id
 d75a77b69052e-5148e94d952mr24073221cf.32.1778236828776; Fri, 08 May 2026
 03:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507205033.951990-1-vlad.kulikov.c@gmail.com> <af206U20Fvky1g30@ashevche-desk.local>
In-Reply-To: <af206U20Fvky1g30@ashevche-desk.local>
From: Vlad <vlad.kulikov.c@gmail.com>
Date: Fri, 8 May 2026 13:40:17 +0300
X-Gm-Features: AVHnY4LxMz11yqQxZHkPRnJIUn116WWMOYnaQqTdS60NOVrbHnvNh-hNfw-LAs0
Message-ID: <CAMY8kpTR3Mt1Onim0etLaoGLkRd1UyXrHJaW=Z-2CQ=7CSJwbA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add MEMSIC MMC5983MA driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, May 8, 2026 at 1:03 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> My comment from v1 still applies. Note, when sending a new version of a driver
> like this, give approximately as many days as hundreds of LoC in it.
> The bare minimum 24h anyway.

Thanks, understood about the revision cadence. I will wait longer before
sending the next version.

I did include a short explanation in patch 1/2, but I see that it should
also be visible in the cover letter for a new driver series. Unless you
think the existing note in patch 1/2 is sufficient, I will add a
dedicated "why a new driver" section to the cover letter in v3.

Best regards,
Vladi
