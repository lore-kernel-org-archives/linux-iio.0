Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC1378828
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644117; cv=none; b=ISDlhC9SDy8ljiCL0SS/CQYzYahHxZJFIVtMuPq8b499qX885Vj5cqzP76tDa53rRixlwebYJ68Ubf+dc/i4Yh7eOql1kDvoKoDTvVkrJjN3+5itqORaWSyx2tWAFW5p29WCC+QwBTt2IEZ/UHevPeeRwvWqCYUhzDnnYTzzp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644117; c=relaxed/simple;
	bh=tReKhaGtE4+QoatPKLKAhhW3zT81i5diu1/12wCr4D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FJQHq7L7gsJME9jjGgdZ7sjd3lUWWoqcAz+vnZnB07KpADIr4Co5CfoPgBv4OkLj19bcW4XuTRrLVJFOyA0ZODwZXt6khyH8nB8RQUIAOpimgD4IwlFtNZoOYPbbaWsu/oDe3kQ9d9L16lkQtrt85FWAw1RT472OkLXya8ruNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1Hx4vWo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1Hx4vWo"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f7444576cso1765592f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644114; x=1785248914; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=udKt9H/K1sVDd3wiWbRrjXOunKdQcZQZJAIWHYJxEpw=;
        b=W1Hx4vWostUPMkKZMvv0bkYKGRJG572ah2NI7QNm0jUNiqRhAMTlclwqqwepfPV7g2
         2gnG/1tjjiEPr7KABVnIELmVKFwy8aFgRaADVFsvW7WRwOxGWm0yqLnamcozFUPfAUcx
         n2yvkYVh4Cs3MbCMZYyjESODWG2Su25N7IPkA7g+ieiDPstBeJPDpOrhBL3uWq68XLta
         xMjvbpn+88njW1IvvAPZdPqGvJLTeiaFmnKb7ATBbjyRHXSReOJxj2wLoCwNEqYHMtYB
         g5oYL4/Ho8vlOnB5OnCc7wcdoIIQuS80Y4izDErRyLdoS0hx2GkPBLyT5WLTF9M6/tLj
         sXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644114; x=1785248914;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=udKt9H/K1sVDd3wiWbRrjXOunKdQcZQZJAIWHYJxEpw=;
        b=etWi19wXghkCcYHsdpuN0dG9ndsAgcXhHPXZJGr1V0WA/NSrncy99AQCJE/lqtamaK
         yACsOrOqCPRQodkdrH62RQkvjTrnlrA0SRFSluZw8yXhnMWCruyiSpK2pgzqR3BMpQEC
         FwgzuaEzaNmoE5pTXV2JgcjkUQjoUxVJoj+VuSgd8yR+LQ2/Ua2iCqi+4FbJqhncYyMr
         hxPxdlOg9Q92d4szFj7x/Q/IX8T9WRhWFklIugUPe7IKlth1NcxPQs9vReoWVlZS82VU
         pgGycGDwuaOg6IpmlIyUQ4d2QjLYkLnu+f7CSVNpHv/0ObEZxvCk5RNb5IEmKC+VudQo
         ENKw==
X-Gm-Message-State: AOJu0Yxwl9k0n3EdRklSjnJLij0Z9SzaLWAswRWc0+dq5e5y0nqZ5Xhi
	AOyt8XQVDuDDmFC1XZhwLTy5S+kjxRU6Dn8va4AViDaycasrpBJ9NX1Taj44Ggs2
X-Gm-Gg: AR+sD11IrdBBltt2HNVNsF8ng7riCENIufch2bGxhvvPKVwpbe16PoTK2u8HOvJYqkp
	0VNNT6G2XgO9Yxd+b6nYhNluVMP0ZHdpxalqsvHTVEERcFIrUM8xCmEm1xcHIy+dj61qLEl7e3B
	hJ+UMKY0N5oSoSOhpq+qPon4BtjUSpO65Z0rVEcD96CGhmrcje/jo29U/J0iut9psD8ACOJy7FK
	TdK0uqWf2oXyezZMyfVkwnVGCIBSo0sUXwIgF6bKXCFZXiOszQdCnGu6obgvThJnj7js2OhQldW
	aqRnFyFnL/O0QNSMM4OB0EAYzjJE1EHff1YpkOi8eXFw6luB2tiB3Lno0xusd/DiBuBVMePRWF4
	qW2XYAwbmvTp9GTGbVnJowabVP1Ocln+reZRqqHutzxwRBS06JxqDe/6vfW+sU8C3umQrzF0rZb
	IgpTXTeiBs9haG3j8JBGWEBVGtSV9hyNBOB/gDxPswEVdcQmVFjry/DvdzoOt/QRmOHNhwJY6cK
	w7OVrFDNRRY3SmrowNaE9cjl8TosCqV/jfTCVAPoXbDEkIedKj7gka/SmQk8CQVAVsibdlz7H9w
	+ButusaGmP5wY/B6/4LU1gPqhG7FetyHr8PrsadihJs=
X-Received: by 2002:a05:6000:619:b0:464:8d68:618a with SMTP id ffacd0b85a97d-47f62328339mr21322953f8f.32.1784644114328;
        Tue, 21 Jul 2026 07:28:34 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7f55sm35003310f8f.18.2026.07.21.07.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:28:33 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 21 Jul 2026 16:28:19 +0200
Subject: [PATCH] MAINTAINERS: add mailing list to veml3328 entry
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-veml3328-maitainers-v1-1-8166db77c79c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAIBRA0a3IGyf4yX5biQZWr3qQFhoRSHtPG
 p7BvQkiBsIIHUsQ8KZIh8+QBYNps35FTnM2KKEqUSvJb3S71qrhztJlyWOIfDRGlyjrqTQt5PI
 MuNDzX/vhfT8S5TV0ZQAAAA==
X-Change-ID: 20260721-veml3328-maitainers-b5534e17c459
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784644113; l=730;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=tReKhaGtE4+QoatPKLKAhhW3zT81i5diu1/12wCr4D8=;
 b=VshKbRJJYuus7GtP5AShuAaduqlTeZbrPlNKzgqwpfkPLeDaN+OZnnQC70Z8kGP9OEF7+oXFk
 erZA3z0z7NTDXkVhQi9U2mjiagJa7UP3/kN3dYX+ZeqpbR3LZKhuGCd
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Add the IIO mailing list to VEML3328 entry in MAINTAINERS, as it is
standard to do so.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1ec46c5919..013f6fe6324e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28777,6 +28777,7 @@ F:	drivers/iio/light/veml3235.c
 
 VISHAY VEML3328 RGB IR LIGHT SENSOR DRIVER
 M:	Joshua Crofts <joshua.crofts1@gmail.com>
+L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/light/veml3328.c
 

---
base-commit: 036d96ceec6d966339aea34d034420991e24cfac
change-id: 20260721-veml3328-maitainers-b5534e17c459

Best regards,
-- 
Kind regards,
Joshua Crofts

