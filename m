Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07DD477E23
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805593; cv=none; b=Zf9hsRBYXpHa/Bw4X4+D+tN84lG8pUkWEIJcobNGFtP9sxu0r1m7XP/CgMLQVyehXO8kPHgkVke9l6nHSP1280yweiKPtVwH+hnUbaWxY3ppGE7OdcF37NNJXEZYG1kChUHv/qR6cJOTvNEb8Cw38DX9HPcRGvvS1LmWMj1k/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805593; c=relaxed/simple;
	bh=2H2R+h3ploQ9mGwP0LMTSWcS73/fZZh2+9TzpxjVCCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I78VhFvtu2r5LcFfFPV/aYPB/wMwp5FQElOg84aNfZpMluKe4z2T80/ZNoeQ6cjsLOEqxKxYl6OlktSfb8ma8y3MHnxASnpEjqxi+IJfpzmyu4kgGuU496Gu8EJge/BoqLa726PFfv+QMShQbR/ChgWX20lTTfe8HbpfIMl+8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwaE5tch; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwaE5tch"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acbdbc1725so2116206a12.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791805590; x=1792410390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDIKLW4OfQ4CZa1KsqrPUiZIfzQyCk0BDHwYXVAthtg=;
        b=UwaE5tchti1TEq5ukWctJ9AoTBbJpdptLS0iROz9TLmpQvYAzMWpiPJ6QvgwGQRMKA
         b9Ph4zxLqbBwu5Sl6sqLVnJFDT4spyuEzYUjDxRU9M++5SGqUyBnLKV5T5ZuhtiHTCM4
         8ckeEI8MJKslLOvjpZgZzwvYaW0WXq4lifINW7+wVYbT0LBAMQ+/XDOOpBQimTC23eot
         YudDC7hpsHEK1aX/jfaNp20VJ9hmQwT6icgu2/cBDInN0lEse8WkFi/v0KABH4uDrjGl
         7OZsDkk/Yaug6kCzI2m8mlo/dhKS0mf5zYnGlsEBPes2X+aTrY8VW0EU67FEoHr4V1L/
         oKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805590; x=1792410390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dDIKLW4OfQ4CZa1KsqrPUiZIfzQyCk0BDHwYXVAthtg=;
        b=VSlt5UIqiH42upGkhQV/JXSTSlnDqI5g3DBwsE1wxOFN0LWCcU7jyC5g4Hx3yB3Jg4
         9SOLjwwc2Qk8cLNmHnyz4pDjGYyGva8w0ROQ7Cvjm5b4qMvm8vf2qIlFyLvVOar9lkKU
         vwbdMFrG1HXzTdeSJL3Hy3y4zXT/2bsqeELOUQboCDrkJpLJ3i0M8Bpkk+SnUMeyXtCW
         Dd1IsheU9tSLxLKfxoRdzOEvYcXV4pOkn11SXsxQbKdk6WEwXr27JXfOFqMe0ocK+rK2
         ScYWq2xceK5AoCYOi53Lxs6NzWWNigrvF6nbh3M8PXeAblfU5MLHQuduBvnV69CY3Kgt
         gM7A==
X-Forwarded-Encrypted: i=1; AKwUvBwh5KZrmPC7paHQOS6e3V+jQfA7+FvNVjBUcOmYP0b4TH2dqSOvkfIC1rT1MXaTSKSMbiO/LOi5XTM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJL0K/6GuyXtYufGEzJs7Ap4kbK4o7Cqs+rwqZ4OeC2DCcZzID+
	hqaX8oS+R2cJj4zF2Ql9m55XKqqtPX/wyE6aAxpBVj0NKmY1EVazk+3DQOC0OhYu
X-Gm-Gg: AYBFou0OB+NFeXvllpklWbqfYAUBp6y1YC/gw+hMUoxFOFVu01PDyquligUtI9ukrt5
	8K02m2aYlouPwFFjohLpW5OdmgI/ft25qjCYDyBxcSydJzEwZfvEXXLnCdw+DPbjhxOfp+Wff/1
	LNcbEDjGf5O7rAspeXSLsfNyrO5ftuv2AEEVnyfEZX6/2RjVJ0rrhmMn/xBXXtnPPsfBnYzz2XJ
	/77BTTyZgfDF/U2eBlR9L9EH6mhfkQv+fEMjv1jRCqNkia5BfTbrZiorXSXwG95h3YHkUwjT9HX
	BcrW6YDNbSZar6wuDBPbDldp2UyFJr485gwUe36gMxVrYbCIt1e58yGL7X2I3SMXvXNmM6XUPql
	1nHSxCwC+WfD38YPMCeW8NpLTzvo7F+OcAZZjNd6c8kjAz3UEwYn4sIfE2OOesGyFS3OcR90NmT
	y0QYdTLk9izW7fsft60P3ooLCBCcLNZFMdPIrV/goz0K/LJielXNNB9vBLAOjKp7rf3gnt/l5DV
	dz4qJQhDNfP74vEO6b6AvojroyPqnoVhWFYeuAi4bZll7r3yWSuEc+12suPssBKXASnTXyexWqA
	NH4L3/o8vNfpt1LBpC2OJe4N
X-Received: by 2002:a17:907:7b9c:b0:c29:5996:6624 with SMTP id a640c23a62f3a-c31aa0ac6e2mr845327066b.37.1791805589670;
        Mon, 12 Oct 2026 04:46:29 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c34d011dfccsm118669266b.42.2026.10.12.04.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:46:28 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
X-Google-Original-From: Paulius Zaleckas <paulius.zaleckas@ui.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 2/4] dt-bindings: vendor-prefixes: Add ZillTek Technology
Date: Mon, 12 Oct 2026 14:45:48 +0300
Message-ID: <20261012114550.1680054-3-paulius.zaleckas@ui.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012114550.1680054-1-paulius.zaleckas@ui.com>
References: <20261012114550.1680054-1-paulius.zaleckas@ui.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulius Zaleckas <paulius.zaleckas@gmail.com>

ZillTek Technology Corp. (Hsinchu, Taiwan) makes MEMS microphones and
barometric pressure sensors such as the ZTS8032.

Link: https://www.zilltek.com/
Assisted-by: LLM
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..255dc56edc36 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1977,6 +1977,8 @@ patternProperties:
     description: Shenzhen Zidoo Technology Co., Ltd.
   "^zii,.*":
     description: Zodiac Inflight Innovations
+  "^zilltek,.*":
+    description: ZillTek Technology Corp.
   "^zinitix,.*":
     description: Zinitix Co., Ltd
   "^zkmagic,.*":
-- 
2.55.0

