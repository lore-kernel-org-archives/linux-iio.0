Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A991F346E7A
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112508; cv=pass; b=Dg6t2GNYFw0pCNIlsJaNaxKixiwYxM9rqaiYFvZFIGTUdgTa1zIQAjzpDZTAhlWEfVoBKCKCH9cdAspjZx+liOkVlk3I2ew9jAZ7NGfCfjfrrPfD8XbxO0257KZe/mSVMi5OhpVUDfHV9IdZmQTZ0B52ZOG7FEAT7SM9eBCJ9sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112508; c=relaxed/simple;
	bh=9U3bW6Dfr4i2owtknQPFs7hcgVQigm/hLkQu+nof8q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVcH1OWA55IKBYs66h4eZg6SyQ7XeJiSwWGtsV4ZTBg7FaT0gj8W4RIjfIZvZsKh9iLXz3Y9pCF/5D4M1MBUKgQRdmpg+ViS40wrylPWEQzDfXLXDNTxsGmysXUHeFe/AuHq9jcMmomRzznK+AcNCpztj/cLLEzrum+xzw79jpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfsULS9r; arc=pass smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfsULS9r"
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-69d8091533bso2861919eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 10:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781112506; cv=none;
        d=google.com; s=arc-20240605;
        b=Sp+fldsw+gbzi2RqTnAqA1nbOEBf0a4oFH1TGszP4RxxgEfY0eyHf6iCIYxzo+xB6b
         03lgl1f2//boc7uKrvyGBcjMs3keSte7OUzjuAoAIHIDnsG9KxSAd2jE2BAdA/kXAyUL
         0KCercZ90I0YZ5LLVFpXi+SLQkRDY0MfKGRb9Qgn9f1zpN6w8Gx2EhLUZqmniVAX7WTg
         Vjjj+tLRCkmyTw9mJoXXInl2aSiQ2scarfwPZo3g1863Q6av63vCCjv/4N4NF73Jxw2t
         2/oAZp6BhiFd9PFu2SAk1cl1dmk4pRV4nlfdR4uqM4b6e4mfy4241yhsHupWR7zNNwwt
         dowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9U3bW6Dfr4i2owtknQPFs7hcgVQigm/hLkQu+nof8q0=;
        fh=qfPnLSurxls6WyB9ZWBXZgrpBa90OMBgu31611bNCuM=;
        b=fjEst57Sh2T76tasE/OYFKEFhJkmkQFnG5w/OZ6nHyQrLW6cJDwWBgWyKOVSVuIMDN
         /t/yA+2USqi4H8i2VA9JqZjl64dxAKRPXQlOsDG2SjgS8IwrrMtb+deK/7mKKtYy756X
         rCpkQGmPYZGaddy8sz7Qo5Hr9/lsPYqJapoiPi3P1YqrpUOHhQgK3xM7VFpTpc9RDlOX
         BpNqGY2CKFZHbJAgXOrYKRzqNX585b6KETOJ+Bay12WMpKrLpr6f1dgj+k999znRp+l0
         tvPhHUFJnSXR15HajCG7Wgn1xApXkoe09VReghoZaZDZwwzqB0PghL3XQCy5vRWtC+uX
         SI/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781112506; x=1781717306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9U3bW6Dfr4i2owtknQPFs7hcgVQigm/hLkQu+nof8q0=;
        b=gfsULS9rRN+J4PKrr5wMMXvBy3KaXoL0rqUBn1/CaN+dSfMI3PRNHoi87ObLMHrgUU
         hAmF7ykLYomsob9d+bTo7QzQV0N1jjOA5GKjFov38V8NXI0ZnXeRlRwBq9+YsvKoefKI
         872k4irZSTiSdBpnH5Uz1WYjSHvSfQTbhWf6AWfCw0+4mOdVNrqtjdU+f7iQnujT1ew2
         LKgVtyb6mpsizkmy7hEuiH+TyVn67kSPOK/AZYIc7XwtLROALUvYKi9MLqSWezHC1EQn
         7U5j3mw7tuwfo6urstSs5u9sPc1z0fkqfXcp7gesc/wmkKOCJi0opCSResEQfnzByvde
         yhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112506; x=1781717306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U3bW6Dfr4i2owtknQPFs7hcgVQigm/hLkQu+nof8q0=;
        b=hbyJzEj9wbqXYy1L3nJf0jrGnpGlB5nU9FxEWnhL63N+BSwt0qJCfrXug/BcS0AK4T
         NlpbOigBcw/t/8DnJ5dRfTvanTHc9AMKnf5KNhMH1KNgYyWvBV4eVvxZzqwc3TRLMVXC
         IiNRrXrNheDezE0/Vml6MXPlFhLqTFWb9r7RfV6xVphlu7zfZFsa1P09zErmZDxnURP3
         YEFJjseWtHKmV1ZvsPDzHdXRbWy86U7d2gUGOeG0TRI2xVpvCHO4gnsFSMRwd/UHpprZ
         X9cnj9kdZ81ru9/3BdVQgW81gyzqHSDlebMhkHiS/HbQAl5jLzifsUDgUHJjx0Eb9btW
         603w==
X-Forwarded-Encrypted: i=1; AFNElJ+K/4hizZzPqtEHShtGEbNZvxyS0C9PKFxiSrR34f9x50fc1kWgCoT9/VfL9JCD3nb502lZbSxUGFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVXpZdamqY2CZPRJS5vrh6vow5EOswY0UJyqraouoddTo0wka
	JuE7Q6rcErfcx0aNOs9iHeA3XeXaxmc59ffDIgvHZAjF6xLwvmw5e47qFLHxD5AIaGVPsWd7Wr3
	K+kQ91McZ+RZ/u4UwMbqaAxKm/jWf+hY=
X-Gm-Gg: Acq92OGbqI9m9hUxPmU5cwqAIBUn184dWs57Ods6SK7hP9T4T0VxENVN3Y2yxFnd+zV
	kLsH77ok5rPpV1/ECIv25piFgruS2dEkUkin2SOiNSQZwg0zalzLOweBJ8vm1jAO0LP9am0Nf/u
	8FHjhshwjRAj7bw7iV09XYFv0ipjHoEMJsCUX1rvUYYnI4owkqBj9QM+d5kItEKmnnYrv/K8c0j
	KNzZcNNFRia3hfmtm5M2/nKiAi+/sTAnJxTEQImt03mt+dPrbj1O2y4Q+1FITFAqB/5djhGg27W
	JSDXJEsywWD/pdwLOoXK5VX8nNLa5Ky04Dh5X+Wx8MSL1e+PUHEY
X-Received: by 2002:a05:6820:80c7:b0:69e:2e0a:58dd with SMTP id
 006d021491bc7-69e68c25334mr18749045eaf.38.1781112506642; Wed, 10 Jun 2026
 10:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610135831.91739-1-dennylin0707@gmail.com>
 <20260610135831.91739-3-dennylin0707@gmail.com> <20260610163230.51d5866c@jic23-huawei>
In-Reply-To: <20260610163230.51d5866c@jic23-huawei>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 10 Jun 2026 10:28:15 -0700
X-Gm-Features: AVVi8Cf1KtdLVqpH7_KMX6sUK5YIz2BPc7hSN91n_QJ0-l0PXrl8kaFzCE1TrRQ
Message-ID: <CAGEkeHcHOOGnv1DFNTCWSNDRMH09u+=cXkOqJnUs74Nfc1wU2w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The alignment is not the preferred amount for pretty much all cases.
> Rather than go to v7, applied but with this fix up:
> Note that it is on the testing branch of iio.git which will get rebased
> on rc1 once available in about 3 weeks time.

Thanks for the review and for applying the series.

I appreciate the fixup and will be more careful about posting
multiple revisions in quick succession in the future.

Thanks,
Hungyu
