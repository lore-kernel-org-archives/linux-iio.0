Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18A3E1D1C
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104712; cv=none; b=XTdjfinh1h8JrG8OVxMYhBbR1DtVeStsp6fdlsTk8ei7L7MTAQpIrKs3cmWyIbMHBa97i6jLt3XCZFFqeStSQWUMUnRLWOumW0SvSNdtpRaceSlV4S21qR4BMnR/lyxqkKWhVUgcTmibS1z/Xjz53DqEwmUybxOmclCxlC3Znng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104712; c=relaxed/simple;
	bh=oem4IMVPK2NhKna+J6ughkzUgCnu/vCJn4mkH0vRr0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdpQjFtY5n0ykSR0r0km+JjPB9DoHHnfH8jnk8HWet603PcDAo1qw8oDj5FEhbU2lFV9bT8Pex+PeiDNsbI4GlsK+yw2ChEcnYWIkTKjf6a102pD/oUPCkCCpqg1sEauKBwnIEwdG6nz+jIYsDF6dIPpZj9z4gaOlPR5DBSpZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCtztQhl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VU3zrWZY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCtztQhl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU3zrWZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779104709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AlBqXl+zcv27ISWHI32Lwsf7wLr0+r4751NpMP8Mpt8=;
	b=LCtztQhlSnVH2ZFzsT05ZLng7EaQ1XQby6RaOZv/T9GP92AaNl14x/L7a7GsHXRXD3+l+s
	Iyw1K0Yn0VdC6qOQDanGErj/L41xfOvz0g/IcEW2wjDrQZ1G1BWFcU5JdZRlwRbKAqhBg4
	J+R3L94NNhdEwnE8BDrKW3ZkJjsTY8c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-WJK6okBIP-OSE0aF1okc6g-1; Mon, 18 May 2026 07:45:08 -0400
X-MC-Unique: WJK6okBIP-OSE0aF1okc6g-1
X-Mimecast-MFC-AGG-ID: WJK6okBIP-OSE0aF1okc6g_1779104707
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d9ace59efso1507576f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779104707; x=1779709507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AlBqXl+zcv27ISWHI32Lwsf7wLr0+r4751NpMP8Mpt8=;
        b=VU3zrWZYk4zhv882hFIbdz66akuTGugJO+rkHd5y7/Ns7vPEgH0URE6DrkoeAmMv0A
         ps58T+FqGkc9cJtBYvOVc7ga1toMdJWMFbzgLeOaOKga3rydIrouLFscyrziKQlIU2fY
         xv8Xn8nu82gd9L6shj2sad4X60iTKNuWgLMDHN76hGaia1OaB0gyqibWr8AyJCXCU8wS
         NwUcl9Nd3xmv+CUCm0xbxNfgCm+v9xMTQwNaM+49repR892n77PQQymsyxliv+WuLQVY
         AjscklNYLdMxaN7YO6h937RhDXLRJEjR9O+biHisMd8C3AYg93QfVYYo3i8x2i8O4nGa
         1cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779104707; x=1779709507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlBqXl+zcv27ISWHI32Lwsf7wLr0+r4751NpMP8Mpt8=;
        b=DMl4fHoG9kEkYYCXB6I8XP6bU9Q+qn4EZeNwccSfKhAUyUiVTEdUKtqSLai9rzKwJi
         qUT4f9Wq/BtfzBIDvjRCicOaKMdzE8pE4Bb3SePfaNiWKM32R6ZLtovjAR9Eu22/aIwL
         1QivGHfLwaV+reaf/iB8aAVbN6tE2Kfk9jPfGYSz9sv4u3gsJ97paZCKdD4Xo4KmPxGP
         7IF/OqePOmj1WIuY5d9QGtKeroo7TtQhMeLfJfvskbU6VomfhHuBXn8Gg1B34OJQ6//w
         N3aDtI6xejD+SzCDRFXGqjAwN9c3WrhMIC9TPQkGebznpK0Aq1Foq2cl7vXlR8GZM0zG
         afOw==
X-Forwarded-Encrypted: i=1; AFNElJ8L0DexkmOA58sTFtXjAenjEvPotKZMjOUZiErKRIgYCLYfbNGp0QOX9QHT137Cs9KCl/1FLz5e4ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBD4vAELMOwZ/Tv1Z/60wA0EteKPJdqBjeTTD2wlQwQZxPXyu
	6qrP4d6j3FpFlbr+R9YXwzObFtVfDPeCV7bqE8LX0tA6NQmPsUuGZPUQJ2rmfUBfDCEBY/xgk2U
	3M1YJ9evxavNM9ILZjO+Xq2dozQHpqPy0lXKxkzeH0dv+5QQiSqVsFscW5D8eSA==
X-Gm-Gg: Acq92OFTjIjAhZKBoW+jjlaPruDxyqDoNnDt4dZTgIDk5j0wU0jBgbdjX7X0DNMgYiO
	MIrHF2Nh85nLp4tUtlhohpkzioXv3bIeIUOlVBJ8aVogAsL6LJhHaK9HJNQAhJusGTuNNHgJqgP
	Bt2MJWOpZI6mT0N5KYYmvMX98wzGJadLRWQ7y7Ep+zpVsnfhsiPpz3cpMAlrQwhW2wvlbf4JRgj
	TIqd9jetnZBUM17IghXzH9cwBGPCZZgERCEH8Vgtf729+LukemI9ZpNEOKoMaDbsDVvdz3ePB6o
	t6tZpADFkLcgfEuQwYaESt1kYjzUIQDaHcHInIVQDFjrkSPmfDQmlmPR9dd047sK+iSiXkHPKUO
	OgEzl2BpE+8vV/ZkI9Y5iSz8gWVV1x3pC338/h/hRN+ns/0Y67q8jgG2I/8SR964kkIdJ9TA=
X-Received: by 2002:a5d:5f90:0:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-45e5c5be273mr22658941f8f.11.1779104706742;
        Mon, 18 May 2026 04:45:06 -0700 (PDT)
X-Received: by 2002:a5d:5f90:0:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-45e5c5be273mr22658887f8f.11.1779104706289;
        Mon, 18 May 2026 04:45:06 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a562dsm36975605f8f.33.2026.05.18.04.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:45:05 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Radu Sabau <radu.sabau@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in ANALOG DEVICES INC AD4691 DRIVER
Date: Mon, 18 May 2026 13:45:02 +0200
Message-ID: <20260518114502.219375-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 963d07535e77 ("docs: iio: adc: ad4691: add driver documentation")
adds a file entry in the MAINTAINERS section ANALOG DEVICES INC AD4691
DRIVER referring to the non-existing file drivers/iio/adc/ad4691.rst. This
commit however adds Documentation/iio/ad4691.rst; so likely, the file entry
intends to refer to that newly added file.

Correct the file entry to refer to the intended file.

Fixes: 963d07535e77 ("docs: iio: adc: ad4691: add driver documentation")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f877e5aaf2c7..c2539ffc179b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1507,8 +1507,8 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml
+F:	Documentation/iio/ad4691.rst
 F:	drivers/iio/adc/ad4691.c
-F:	drivers/iio/adc/ad4691.rst
 
 ANALOG DEVICES INC AD4695 DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
-- 
2.54.0

