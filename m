Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBA32B13F
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961277; cv=pass; b=FDIxuXFk4x5Dktuapq5806Fe8jkih2V45SfTZPPDJFpBASua0lKE5eHz4VoWf3pbx9MpOzIBRAQXhsZVq1Ah+GPrdY6/uJNIb/yxa9IEuZpOPE7RygiM+z1lzjMsvS/vpcPLOnDGaIcSMDbHQWpJtA7saW8qwdbgGM3PtD68YeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961277; c=relaxed/simple;
	bh=37N48hBsVSHlJ1BfuHRgKHdqsWk9adNv1YLls6cyK4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtKnXVDXmvClmClgnFeYRMUi3E6DwoDRbCpf5jtYAo8gATpHS62klqKQB5SmUnu1U/3EiUkFbTIgtuC7qc+M0NsMZkJng1OokIUvQz35iqzYY+6ej53HZKXdiwg73xCg7eNOfl0uDdrEjX26c+mI9gjXq3ZAGBJKYAvZ8SOrZK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH3TM8Zk; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH3TM8Zk"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30749947917so2400766eec.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 16:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780961276; cv=none;
        d=google.com; s=arc-20240605;
        b=IKoufbCe3T+vw2HpYIidDT9PFIea6JLGSTiqLtp+mNX8KI0j0QEZTB6Iicdi0h7fWH
         vFqMxR/HyusZNqRdsv6iJahoWRPporqtkGJkVcUoI8u/D9H3C95EPPKyI9ZT4WSLYEsd
         roowkfAwEcVAx7TwrJ5FM9WghjYDS7d7pMx92kU6SSSmqEY5sndUb0x6drtjK556iXYR
         FenvDKAZkfFLu3/To8EtjHpiAPQQoBWhDCYFBRMWeyf+pvYEqbuZ4sE7r5w8/D6h2jg4
         aQDLA6Hs1jrPiWWfOwckALBliq3Qgs0YbiNasViLSnb2Vo9OOGuvUOmXZDV29ygtuv16
         0OeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=37N48hBsVSHlJ1BfuHRgKHdqsWk9adNv1YLls6cyK4s=;
        fh=E7XxKp5dwTm/L8J+WSmVEt2qp8R0k1jIyo3JIIUBUIw=;
        b=LKP6p77/QsoCkimzpmVykdyfFJ29S28Ir9mB2ztUIxHVs9puvakusQg9HStHIjFYDK
         S6JwDixdkW4PKEg7OnhDPidwAToODrzWipS73xwQWxjPuZCf0cSHWgIDVgzpJHLSpsnL
         st2jcQvFuz2qbBjg3aKfw2WtPTmmaO8DGWFCiWWIa7QK+q/EIH9GJTF08Z71k0+/RMjZ
         eOxtbhnm0HigAoS1TvagYSp6R7c72qXHCeYDw7XwJ6npu9L4P3PkMKSA4RREadW6r+NI
         PPat475cY8Xv9MnRDkQHORdJ2zMfBSGn4hPiSRggxpdant3zTW8QHwyNjw5vdCCNgaSK
         9EUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961276; x=1781566076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=37N48hBsVSHlJ1BfuHRgKHdqsWk9adNv1YLls6cyK4s=;
        b=mH3TM8ZkMa/LQbgaaTu514J4l+waCs5Pf/HRs6/kDuXY8YnLVbj9e90lils/q4jQft
         kkyfeVsYFm7irERhwYMZTaRTntl2ZuvXAPuzlKM2wzg97+L3cq+GbarrJEqN8ve+j3QQ
         g4y7dOleOG5PMiwiLjYAysOX3Ayf7UXRzgZ5EKhkiuhNW+C29Q3mpwztY1upe/YZxXSG
         TQocvT9Zi2Vzh+e/OR8GDYzmE9INcE2XJdoqxc3lull4hJRfLREAvosMhGkWxjg/oVkC
         v7yacluTzddbUvoaE4njq/pnkBWncAySttoyPB4MKi+3njNhgOig8b37NI/u4tMJtTNh
         82wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961276; x=1781566076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37N48hBsVSHlJ1BfuHRgKHdqsWk9adNv1YLls6cyK4s=;
        b=rT0xhKy/t/KyqAWfRu6Nvpni3n+ikjw6JvsUeBmt35awIujmJGL7QGWTvl5u7xwbtf
         RnocXgXrqgmixiT4nVg6lxeew6N77dlisHyYk3+RxD+qijFvPFXEWseGYGqjBAByAyzE
         jr3Serv2KhrZ08pbCX4vcIqyrPanSXOR4W71xAPtH+p5z9Pf12ucF9QMvfS3WfhOpnV9
         MpzdFwawv+ORVMAjvsgGcVLBGJKiXXW+J5kt7MG0004Fqv+rA5aBJFA32RHUDJFKa/EY
         ZFzn8jPrMVJIHpezxSHNN/4TAVcZvFOzCbLLmuGqlVb5Oqzw17XiHfOCl4au8axamkOA
         D91w==
X-Forwarded-Encrypted: i=1; AFNElJ9i3y3TGvUvZA/u3wcoM756Yl77V3L+7tYHsW4jJSMSrHnJKSaS27gXHpvESV3dE52JrVMHot6U6Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdQJFcRQa1kdpsLNHOf42G/29iOE2eE9xJ8gMRbDCpYOgjwFU
	8aAXwmE4fumg2x95UifOyBF8SggqKldAv7p6v8GUdokfgG3a997LEUXkbTjUm+bzza5pb3Xn9tZ
	TQVdshS/2QHfrIIl5cx98zcccVf2zPVTa8byAQC5WcA==
X-Gm-Gg: Acq92OGmqOMqYdVIfDp5KNX7apcNxpZO6gRuzQpHHFOE3K7XWQ/4eluKoQUNWdxj44p
	g9GmbYOWhwB14YczSKhV0TISVm5jzahAfOOz30aVkAkvpLn0J3iruH1TPlTCGhsOm7eNBu+klsL
	1mXINEHF0Nk4R9mEyj4Eqy5o2KUVekahmQVRVFlMfHpv2FVdsT48qJ3jQdFXSkfgV9QAB5tit4R
	UGtSAQc6LDl0xdHuMimIG+N18igsuhu3b3PlXtdZ3Otb2GZZ6e68jbNaU0HyS6sU9JG4JUk+GUG
	xCivTKqrueYhiuOQuvjp5gQ3pU0j9Q4iOfHqrGm9x9SKPFxZGYLYJe5HOZRVPJTQEJN2Bs1rL3g
	FOh0l7Q==
X-Received: by 2002:a05:7300:fd14:b0:2f1:6252:f8fe with SMTP id
 5a478bee46e88-3077b357c3amr9913759eec.3.1780961275699; Mon, 08 Jun 2026
 16:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607234343.22109-1-kimjinseob88@gmail.com> <20260608-catnap-thinness-e25c9b8983c3@spud>
In-Reply-To: <20260608-catnap-thinness-e25c9b8983c3@spud>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Tue, 9 Jun 2026 08:27:44 +0900
X-Gm-Features: AVVi8Ce0REUbYLB0vBxw1K6HuQCVLf-o9NEPZkSMeMK0OsqgRRaqFSEyfQexrfE
Message-ID: <CALMSewLUvaYuag-8j2v=YoJQ=y9SZySrScZv51F8Ot7bdtXhdQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 0/6] iio: add Open Sensor Fusion IIO driver
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Other than the fact that new revisions must not be sent as a diff on top
> of a prior revision, please stop sending new versions without actually
> replying to my v1 comments.

You are right, sorry for the noise.

I made a process mistake here. I prepared v4 on top of the previously sent
series instead of preparing it as a full standalone replacement series from
the proper base. I will not ask you to review v4 in that form, and I will
prepare the next revision as a full series from a clean base.

I also should have answered your protocol versioning questions directly before
sending another revision.

> What does "v0" mean here? Is the data format not complete yet?
> Are versions of the protocol likely to be backwards compatible?
> Will the device identify what version of the protocol it implements?

The current OSF wire header starts with a fixed 4-byte magic, "OSF0", at a
fixed offset. The same header also carries explicit protocol_major and
protocol_minor fields at fixed offsets.

For the currently supported firmware and driver, protocol_major is 0. The "0"
in "OSF0" is intended to denote the current major wire-format revision, not
the Linux driver identity.

The binding is intended for devices implementing this discoverable OSF header
layout. The driver currently supports protocol major version 0. Minor version
changes are intended to be backward compatible. Incompatible wire-format
changes require a new protocol_major value.

If a future major revision cannot be discovered using the same fixed header
layout, or is not compatible with this binding, it should use a new compatible
string.

I will spell this out in the binding commit message and documentation in the
next revision.

Jinseob
