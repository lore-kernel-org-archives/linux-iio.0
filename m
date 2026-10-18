Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172B42640C
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358691; cv=none; b=AfBumBN2ouwQ2odXngIjnjgl9hi1bZYWs+RSWSZV33Hs2kEuk/0QY/LQi3GXeilByAp5c0d0GjFjFO6HC+bBfJvKE/Dn+VhLbwg9yhmHGGXxMHiVNpXwdax54NoIzoPFs3aNz0MiJUG5qH24bAkipag59pEtzcniNcObh/2jn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358691; c=relaxed/simple;
	bh=3XmYZ70FjHnGHrfOAWnQ7gzII7n7IuFAxA/U8VAcIDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFSnSTH+xhoG8wLCFcYSkpbTy9CKDwNZM0nMmoDuNdAVZa0IGAb5aAMW6yGs5KlKqDZE0Kr3gqky2uzM4FOOc16cJikC+PKbqB5sKDsawMXrQZATFRm13ZfdPFQ0daEwuKNv7zRcHpE9OkyaRDy4br6YonL4/+300kAVvVDqt/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siNqOvmr; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siNqOvmr"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab3dd9670bso3286341fa.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792358688; x=1792963488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XmYZ70FjHnGHrfOAWnQ7gzII7n7IuFAxA/U8VAcIDQ=;
        b=siNqOvmrl13JvTWVucQZ1d1gBww7+u+KoRAEIFGxS3plKkREW0pbq/NT/J4kPdZG1Z
         uyt6/CFsFzPYJVxRj+pG7TDuOybp4nRtg0QPgk+VgYSloA6UtabsD8HxPD27y2NZyLXe
         pvAvRXk9fPPZlijd+B/Tbw0e4UfNl/TXdV9U91WixYz0VLGJt/zHuprexH2PDS1fVGnQ
         aksH4Xu/tkQKqAzttpG7IwQAuwISX5GJ7U1BqaUotV2moJOppppbooA781R770YmDftk
         qgyrExXT1YOQ1tiYjp37ZauJhLsgkTimCWK7Ey+Jtf5XAmulKC1g/I+31qyHjJ3FrXWg
         5QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792358688; x=1792963488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XmYZ70FjHnGHrfOAWnQ7gzII7n7IuFAxA/U8VAcIDQ=;
        b=tl4bcTb5NSUOryd6v+W0BeQluJECVURH1YGim3gZY3ckOWUtb3zBXtnkKA9OtzOrPM
         aSv02PbSFqINGKaiu1KP3hHkLgGTBQmUwY1vk3VPHZ5GF5EZX7tzrs7VgcTi7wWerfb9
         S4/NGTFDiU975+Zk/5qycKadncPQycfl3lOJdrvlH1owMQuTh0MSrfq+P76LTMOVm0i0
         L22WjiRKYgfEa09kUPXQenyweIKa8HC2eBr4fdJ5uHHQOmx2b7kEXe84VmKMg7EVwGPP
         fOag0DiNe7AjGC0ZULXZzZAl/bzitoxwitteuuEZUIo3wUb1CyNu4wXrhCC6VmXBecST
         Cq3g==
X-Forwarded-Encrypted: i=1; AKwUvBxR2LKxM3xZaRjFRcBgx26t1QHPyMXkN5xpH6xHcYiHuYSVTxTiRnUqh1oqMHX4v8q5VjnevRlaUrU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIuJvmyHSMnZk5MDXYBAiOkozcw/VD1GNoCKnbfSwnUkKWqRN0
	Ql8Qx6cTN00lopZb3HZuDFdGPe3Cqf8W1ZxRtlr00uVKdFoym4vcZubu
X-Gm-Gg: AYBFou10WIHv2l2lG2lEubkfnPigdp8uEz9XlselJFFIMKayMWaXhbEow6uSi8csw07
	ddxAohL5AJRg+ZpC+R1JOPgzivQnlqA7CMUCz4ybGP1P+z3OE1Dxvq4KdWWD1/W9ASmrRmbG3zT
	U8W8XiGrQy6v0HAFiFteLTtlU7O/9lN1chaVQKPljUBX2cS9lOp7SnO3sxJW6ZtFQwM8AHoBhTQ
	Zz0KYa/DglQLhkA/UW5m4kGo+5Fv0eWa8xQvObUUd+qiZd4pPS6+37EE7f7JPq0OxgYR6VuiITu
	TuW9syKUPvfodFoeeyK8gBglzQjyxqBSfv4/qKq5GCEX/BAnkZd5GbDoU8RGomOWSw77hPRUUUS
	Fc5zYYo0VMZJACCgG8VMOuQp23hIt/bAe955Ivi4vjKuTyCdGg6/3fijjUuVa980Dadlsz2Jco2
	HI6nqWiPKx4PDQ0rGjJY4DU7WlqHaq1okqj1ciyWY5tn6Kpuat5Et6cDfsXUYSEJUEgZK2v+lKi
	ZN+2N6d9IvWLcYVw2Y3BgtV7eBFhy/i/AybBemwxI3q9ZZZXAj+7L4ay1I80pPhRgGDQVX6xN7z
	44018dw=
X-Received: by 2002:a05:651c:31da:b0:3aa:ee7a:546a with SMTP id 38308e7fff4ca-3ab29401f65mr12085821fa.25.1792358687613;
        Sun, 18 Oct 2026 14:24:47 -0700 (PDT)
Received: from yantra.. (nekmmqtaaozvmkd1587-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:5185:c9b3:741a:edb7])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab28023977sm17218041fa.0.2026.10.18.14.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:24:46 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: paulius.zaleckas@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] iio: pressure: dps310: add Zilltek ZTS8032
Date: Mon, 19 Oct 2026 00:24:45 +0300
Message-ID: <20261018212445.43544-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
References: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 06:35:28PM +0300, Paulius Zaleckas wrote:
> Based on iio/testing, on top of a22dc7ebb21a ("iio: pressure: dps310:
> fix overflow in pressure compensation").

testing now has the FIFO series on top of that. 5/5 conflicts with it in
the header comment and the defines.

Buffered capture without a trigger now reads from the hardware FIFO
(FIFO_EN, 32 entries, flush through RESET bit 7). Does the ZTS8032 have
the same FIFO? If not, it needs a flag in the chip data.

> dt_binding_check passes. I have no DPS310, so patches 3-4 are untested
> on one.

I have one on a BeagleBone Black, can test v5 there.
