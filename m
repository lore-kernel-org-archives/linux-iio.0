Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385037D118
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776612510; cv=pass; b=IMHtPZ7cGJ39mUG13C5KtlLzCJuKGbOJ910XQaHkREmODW/1Bme6TMndnV4hKsN3rw5UmFbHj6vZR+6+GHJaIwBF7nxu38jxA60QzQOCbQrSQ679CIBpBrbcX+mwS/r7sicx2KRkHNpGqDYfbsS4CGLEeUcEugHHS4DCmkrTA9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776612510; c=relaxed/simple;
	bh=1qXxUpRlYChfnIFPcOVlyShFJ76R6A2au0xDr6H6/nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmz1khoGKB+iwwITRWRbESWoK0LtENlRJsqx9whscJlgo2gn11Y1tEIBshgi2atixdlzb7TyFy62TvAXeIUDl7pzbTuRz5dSSCju6juZ36XAa+tTOJchFz65HlRFHjiYHG77uuxbGdFp1WfkuHfn1yECQr6HW6oOvhOFgOcYfLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jxh7CLNH; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxh7CLNH"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a2ee65171so28062647b3.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 08:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776612508; cv=none;
        d=google.com; s=arc-20240605;
        b=JaUralo6huofivw9xgrNpcPEaM/FeLCvcfUNURa0f1dtrfvcZwgX6NZSdmwa65dXVg
         t5BnBjxK7ku/+YNxEjMLCvQvfYmsgYVE9dJayT9A9jG00qNbaiGkDlV6Y6F1F1tygQVX
         odMXoKOwRfWLT00o//uoSbjb4ZMnVYVeUCHIj3VIKIeP3f5IkSkE+O/a1gT9Wcyy1UGU
         f7WJXm8qNfJ3qgObm16NKQJ6HDnBzzrxe/hn4/FbQnaU0rkZu/qWgm6kAD/NOs0bZJSX
         D/5YOkeGBm1B3O56mRXTQQEnKE2yZrVrF9119xvCqX6FXnSUmbi8GWRQCnBiM+mHlNd3
         j0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qXxUpRlYChfnIFPcOVlyShFJ76R6A2au0xDr6H6/nQ=;
        fh=n44IXs+k+Zt/SO/NGz1ZQ5aDMoNPNlx/k5tKvUn3nMU=;
        b=Hv721ZlLRL/s2m1hrsPfbc4V1Jx1JzKzxu/+MICsKOEY1GOczFaSjDTGAX8YqfPybG
         cktmhej75rXtIpnI21CflOsypJdKGljrAMXuGU0BFhAIDsOgJ6MtoCS9BJR4YIE/kr3X
         Xj915f8Uver9DfF6WoioZCpCTEBZEPX98BPZgH68MsbTGBGLjFL0L0DijJrSKrMKvAgY
         TYLiBFguO8F5jjZuwMKKZ0OZMcMQjL6CThy09c3O+yh1/vedBwqF1GKSXume646rx6Zb
         cxBciFA7Zj6cviQvRfZEfXtR0Puequlfw0o7t6G/I9X0mC1GuraRsm2KRCUUt5X79GWO
         VobA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776612508; x=1777217308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qXxUpRlYChfnIFPcOVlyShFJ76R6A2au0xDr6H6/nQ=;
        b=Jxh7CLNHqADfdEqXEy0Z3HBBc7u0H8I/n3gPAV5Fpn2wWjlm//BEMup8raPJFxdGkW
         JAH8OpGxSIUHqCB4qXe2g42/6DirJDiHRSgk3HTMw21YPZD85rT1VY0dx5mCj2d5igQE
         Fguwz880L9OsJBcApzNvNTdPrUabshFrhewQ0gOsrl7LBGPl/M/eIQRQzYDnPoHlmZ+z
         ABNC5YM4mn9bism/yLfskxENeT9ASrCohmUlodVU9Ft4adjL9gju+Dk/RFyAdmFzfW9p
         WT+tFBJsQ0sRsW6nUys3vTTLGiVHTENdzPJ8b358D4SVZzxXGjtgIUvXKpQbpNbQIvBw
         dXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776612508; x=1777217308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qXxUpRlYChfnIFPcOVlyShFJ76R6A2au0xDr6H6/nQ=;
        b=SC9ZMxB1gqQchEK9L2h23VLsMXm85tfM5mTosSl7g0dpaJkogHO2SO7HMNgt0Yeuxn
         4rIh4qEPuyFa9mBGG4SdGHd6ZNGX7xk0DJQjwgHJvHg4UWV4Y3Pb6q0VoCHpc7FWBc3L
         AD67XGtZn+BaeLOWtxGUzO5CSwfQEGsLhcya887dRFy7XkSyobO8oOIgJTB8v24FG1Rc
         xg5kRfOfAaTS+gaoQb/4y5VsB7hJBrS3zts8+wCE3n7uThG0czxO9FDgeuQMjOVY5hwF
         nHWMejXxOk8IJAdDSZqBoT69RC8XwBwyi7Wc6R0cZ4CqPR5RM2b7cinuoiBPrX20a//n
         sb5w==
X-Forwarded-Encrypted: i=1; AFNElJ+Ckwl7hsmb7JRatks/CMkH8ICrbyqA9Z3QTTFLn/0vXoadbJLf+1/gzJ8HHAh9qmpHo2j0f2PjOTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0C6AbGD8lDfTfmYBdEBp571oZVEaTLHnmi/IlEVegWqZztoQ
	lWC23So6/nR7k3MhXVUDZsxdZcFtoy0TSYu40HFRw4eiicYA5RBfrCOyO6OYy8UUIaFXiUpoDSN
	tZUu3tJJxoiC8eF3qNr4fYFv2PMYcpyzTUY9+
X-Gm-Gg: AeBDiettr5FPQ0SunKSBc5jFCZEAcv6QpAg3Sf/2o01/RRbdfRVUtF0y2OG8KkTArm1
	9Cs0wkziYfXEs6cGEw7FocDetAcsYDffIYv2dOOiSEhLYWzTyyJvPW7or8OfUSU3hOeEOAyeft2
	bAMZcZNhradKYf9ElvIJIJi12xjTSXb6I/zhNcHBRyNmnD4vv9zigO3Slp9Ad0Yskzca6ok4czU
	rA2p0AT7nPiv9NlbJNXtR8m+HIGFXdi3V1Kq2cFl5XOLHhwAR1pDFwGOVDAOUtiXHxicGJvU5pH
	9vSiN6q4QKGrtGQ=
X-Received: by 2002:a53:d748:0:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-65310a737b1mr7148641d50.48.1776612508091; Sun, 19 Apr 2026
 08:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419010537.116002-1-m32285159@gmail.com> <20260419123306.1e0bb59b@jic23-huawei>
In-Reply-To: <20260419123306.1e0bb59b@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 19 Apr 2026 10:28:17 -0500
X-Gm-Features: AQROBzBNyCRdEIpZA1X8Ugv19iox4PzSooNAwBVXCuitHY476h6X7rruCph7lGo
Message-ID: <CAKqfh0GDkVy3B5tp=dDyBv5JpJ_=+Yx1ibwVjX-s0NDO=PKcTA@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adc: ad7816: replace sprintf with sysfs_emit
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, gregkh@linuxfoundation.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 6:33=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> Both because that's been underway for a little time and because it makes
> a wider set of improvements, I'd rather we took that one forwards.

Sorry, I didn't see the other patch. I'll focus on the v2 for the srf08
patch for the time being then.

best regards,
maxwell
