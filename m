Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0283290DE
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397253; cv=pass; b=jik8JdJvVqDB21+DPVlUDwTCRHcSmZmbuPs5dVJQTGlYlzdI7cHittwl/9c3IDMD/PliieeMLWgEE/Lz3gWJx/WJOZRCibS9Z/L4MG7nOcgTnXFRiKhCLywBkbMkyi5bB0nmi3wYrmXyoy8EqlztZ0QAXc6d/n5fXEEPaOgoF3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397253; c=relaxed/simple;
	bh=V3Hpii605aaFkjDCR5PNFPRt3G0IDGq4e/OY+7esTWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svbzd+ilIEfKVYY4yszobdKizumxLHX4hkvh/v6z5Lh2C28fwa1JWCh4wLwHnWArnGSIeEOlgzPhrQCOAcCR4rJYKm1+xJpV4ocb1GJoKXM2+auvMIK5AVSOvmwHxoLYYmTY8P3LvPcxICzKX+WpOrJ/vm5SkSLglgWtlFCi4io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSDPuFNZ; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSDPuFNZ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6587cee8b57so3589476d50.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 10:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777397251; cv=none;
        d=google.com; s=arc-20240605;
        b=bYTXScXEyR3LSWZ7K1RDDcbwfjVLp5vUvKtEbq6Xv6dF+U50MNKp5WpYsBMPz116LB
         OGM+Eg72Sv46f91V+ApkPemVgGZK2SMvRQUSE+zqIjVrAQOWEI8S7vpBpxApGtmRGW5e
         UlFk/wUa5x2xdg14EMqGQE1Ig1cdrGaCNpXG8rRf8oQJkIN0QOwgQMH52NPrUyW3IxZs
         1jE5xAG2wTUJdekuNModqu5FUAg4DTb4jOccodSxA5KCKCo8ebiCCe9YUPAZnIE6oggi
         dRjHasrvP43ipNvapto5aunFA4q/xtMkIRzggYB9dnfYXt0GN9mrzIHY8yHSH0L46aBE
         Q/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V3Hpii605aaFkjDCR5PNFPRt3G0IDGq4e/OY+7esTWo=;
        fh=alDP3ARqXexO3oHeUlk+ilROKyCM7oMMDhcxXWPaYMs=;
        b=hm5qS1eQQap3xIMWxrDA+JQ7xqpoBYGcTPgirp9uTqJ31rKUERU2A4I9TpktB6CsrD
         IAR+36T3vsnKaqcdSt8Nd3wazTDyrSd4TWgztSNKeH8XjhPunXVh3eF34ID5NRpYPL15
         LTZz2V5kPkpjhYGTG8k9+JCyiSH973bRHMPplsGX3J4HbO58H3A94SAPdm6y4i3JwHm6
         VJtgMnSLL0m0pS7U2ln6j3+jcyHGfDwSfhyirrkEFOFd4Ik/lz2VkrFe+poLpvDlEV6t
         bIKFJTUyhqmd5Kv3H35IxRxp/6W8Wz2CZUuE2V4qKCxFScUOUkjnixbKqmqsifTKd1Zs
         C1+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777397251; x=1778002051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3Hpii605aaFkjDCR5PNFPRt3G0IDGq4e/OY+7esTWo=;
        b=ZSDPuFNZVOba8FVzqbIr99bSpH+IbvShxCiS3+I8vP4jhz3ncOZAtESkvWIHemKjOZ
         CyTPuAe/qb8EOMJt/VyMVvyxa9LMDb5u/2C9M8jW1xjUmfoT9+l9MbOnGjtioy26olHv
         S8HwHPM/jEZrdcUEd+GtPVN4C1jW3+wEbK/eo0lbiKCPdIDjXPKTSiJ248oGDzSnz6V+
         Eb88/e6UW40Qrc5nx0VdEpS5hkMaUXtzIGWFqdYMif6xmQdqndqyBrNdimpP/vQ0488b
         5Ku08wnMn2h/g724XQjxuU8hgb6Ag7uUDTjgm31kPekaw/FqAkz8+TWyDRz6t8/5+Wvi
         0DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397251; x=1778002051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3Hpii605aaFkjDCR5PNFPRt3G0IDGq4e/OY+7esTWo=;
        b=P04Aa+uyq1MUsaDB4NdA+LpJF8dI1bSy8eRr3JYKhDrXa9h3O0jcCb+O71DZv484B2
         kIV+ymP5T9dOlI0ZUhy+rtm6xZJXuJeX6q6f68SF1tN2rZGlDgnRUZ1UzAnjg8a0cMbg
         hWYl6qK43tqK0yoNvv82M1K2v/VE5f05f8sXcchqzQa9rubEafAwRXvfHqcvvNoCWq62
         2E4A89jGtaJuwwWYb9YxZZMJsuuVXX+jNs+VsuIe6mt+nVZeXhWQfWwKvgmjFGCcyJPx
         PDFaN1OI7a4mVpG49+Qc2svFhZhmwZZ87/Ni8TWfHB70B8UrEA0iWk5q7B3SHKXoEU88
         EvAw==
X-Forwarded-Encrypted: i=1; AFNElJ/uO27Tt4l3nGt5Wqy1Q8MhfyJbBSzPKowAdVnh0xa55xTv6rzNvRSDy4a82TQcvBPZtxcNND8todg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSexxniPfIaHPFWBj+gi6hvxlO1Cv6UedJAQAfP/ihVNeekts
	gScJXmJt08XOw2InVYw+XKOC8l8Fmu1ExeOoA/7yvQXugd8Ds+qJEvbxtdSoaTR9kMuAwRl4V5J
	8iRoWY2WfGnTP0jKzzt4SgSPIiOvCZs8=
X-Gm-Gg: AeBDievLm8jq9Ek6OG9wZV0f6EXpQBDUJHoPE3s0LImf7efLNfGTeYhgj8LwjIp04BF
	PEveuTN0+ejDKe97hxl5SAL7iPHejhqWHTj1r+z/YEppx1K5sA0/tPNpdRsdkTM+rK+VLbI65Ar
	mXjf7NoOvlEzIXnIvPzxABgg0WkOHCFTavKR4pKQpV01xTP262rEVHGU7skG8A94DCywhX9/sJa
	I6dTWDCL/4A8JfVz5EoxEhhCxFvEi14lUQTJ7FGJ7QKrCn7SRtzNtaXED4VsCsstMoAhXrgn8dG
	7mT+ozpD8V97bL/+86Lz
X-Received: by 2002:a05:690e:4381:b0:650:fbe:3b45 with SMTP id
 956f58d0204a3-65beedaa74emr2983237d50.23.1777397251006; Tue, 28 Apr 2026
 10:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428124644.49707-1-m32285159@gmail.com> <20260428124644.49707-5-m32285159@gmail.com>
 <20260428163247.4511aa5b@jic23-huawei>
In-Reply-To: <20260428163247.4511aa5b@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 28 Apr 2026 12:27:18 -0500
X-Gm-Features: AVHnY4JZhABl9poAhdiTwVMftSdPMlHXM4kqWKYI-rK5dCt6Yk3vLtRAMcLaRWg
Message-ID: <CAKqfh0HbPJN-L9ji9=Oq=g0UnEk0FES8iQE_mfTpyXdcB5j0Jw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_trigger_handler()
To: Jonathan Cameron <jic23@kernel.org>
Cc: songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:32=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
[snip]
>
> There is even an outside chance of deadlock if you hold a local lock
> when calling iio_trigger_notify_done() as that can call back into the dri=
ver.
> Here you are ok because no trigger_ops are set so there isn't a reenable(=
)
> callback.
>

Given this, I'll also likely go back to scoped_guard as well once we
remove the gotos, that way we'll be able to unlock it before we get to
a potential callback.

best regards,
maxwell
