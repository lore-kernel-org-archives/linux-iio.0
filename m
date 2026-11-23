Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471621;
	b=5soyYQaoF7hM/07DWOMJul/Adg4ZcfPIn7jVBBqaR1AFRabPEg6FvFxiICjUUsAD0lr1
	 FMDYLVcdX3J0aziAXK4QuvIxs/FqOEkM6An2/nTOKT66gSHgRrUdzEt+NsDb6KZ5Ajlfi
	 VCDrkV0JnUFb8+Edl5UcANyIQ9mCU8r0Sn3ul2IBHD7dMjVkoQa28kRHHtBrTqYmYJTCV
	 GklsBE6G/Iiph4GOr/2IRSCdfKsrA9SWiyGlXwl00adk4g1d35Q6+3CRwHrl0T5imdhRG
	 OY4dpTh7ntA8duLeigcbdu3npzJEcEcNr0zpgjSIVXf/EPZhQ70qqdL9XoSHWAhpjNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sr8T3uGYmPFjL96dbI3O0pM2eEn6qa4mBQpuGOtpUTI=;
	b=J5k/ogaBGRj+EwSOr/ZJ12xrtU0vbDVAR9P+JwuzTkdCBwrV57W2U9i8DJILzjStJLPq
	 Bp7kC8Lr+x2yu2AdqkTf/jxv4FXwPLJ9P23JWulIb9pdtuINHrp9v6UVuENuDHZQEulxp
	 vjNsMbfXriDJXEwYVpyJKJUweEDDCb1cs2J6D7hwD8pKQ+V3wwlH6OH3T+czjSAWMNDuv
	 uI0ENi3FEBQEtKmjzOipaK2IHL1tBT6oVaapYm2PuechG6HqW8JDyeLfYBthVfZLgPxrr
	 R1ZOfqvg2C883NCDWm0xmaYjUqJ+xaAiSiJWnh/76/foxYH/XVXH5a8Xl2HuWQk2vxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dja1s4VI;
	arc=none smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E850606A32D
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E850606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dja1s4VI
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ab30b3212aso29953611fa.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471620; x=1796076420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sr8T3uGYmPFjL96dbI3O0pM2eEn6qa4mBQpuGOtpUTI=;
        b=Dja1s4VIIXL5DAMehbDxK8m51568GsKbwHZbGNGNkkp5iSBBmqrhIRBeWxDsanrr2b
         R64dWNQfomGCEPAaA67dCYS1iHx7KNzidVXI/T+iUjVxp8ror5JCG/4HN+BKGNCoiU4u
         n52Vor2dx+uVsdMhQ9oqW3PTMP67E44+n/REeVMP9lQGyZSj5krjk8HKL/ZFVkbNt9t2
         6EKF3KgeShgTIsM3zas7UGCFhXjnVtF/AXg3fl3lfuy+OAuTmfJA6FfTf9hcthwUMHKL
         CFbPY1kCU9reW+Hb3HXqFjSR5kZsLvvQf7rbtn+hBDWRxU3bvYQyto+kwm+N4jNbV3ZO
         rThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471620; x=1796076420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sr8T3uGYmPFjL96dbI3O0pM2eEn6qa4mBQpuGOtpUTI=;
        b=STAI8SuLmO6DnEgMiORPEaNtwmS+Hea+80iyoDAXu/A4k6jAD1yV4xfA7+AqLwfaL/
         zwH6h8TQbodkypNp9458lrDRfyobrgdOAlBmoGKdDYyU/zJnLC88y1dkzunQc408JRVY
         krmc+FC/vbGNrtsm/PckIKUYesZ9BBMkp8KWK+UcKbKStE4DAfjH03ho285Khc1hHALh
         U5doNKjcmA9wWg8yYCrZazritTA1PaRAOPNAUV9n2r6in97QYUmn5eFgA9qBYtLDXXpx
         4BayiSo1MLQkx4Z8rGzze0X/X9X1hgl5Sr9UQeyUJfA/pcmTapD/uE2hCZieJML6ek8V
         52rw==
X-Gm-Message-State: APuU4Z8h7wr6D9DEZKXWGsrXPOXryFAJ8ZXJtdwNmRJjrGKrHdey2DYn
	CbGUM9lu83Tx9OTPOC+q3z5+duzueIGCW+NxA+KDXGQBkyNS2TjWomM5
X-Gm-Gg: AZFdTZfWKqqCBao5n+yx5t7sLFzfrALcGIZiLBGZRRzQ2zYk5G+PfC1IMS+6EeLQ8ej
	4kflz9wUZmpjwHXbCPRzksG1utSiJsT1oC8u87iXI01UNDpNPsePlWjkYojp+/I+lEwtsDxb3SK
	opt8wi/kxrehegZwub+1LaXe+wqUs8EUpC27RA9XGTBjMsmz8DcBzWSFa71hadJRG86koPXEYGL
	Sw3goctmjra7tLFI8+98hFmb0Ts1h/Q8QbfcVy/l59rV20+XDUoE6Kq2hwb3xw4LMKj5kKsVd5q
	NSFOks9Nn/ShOl8yEBu0AZhwq4Ql8BpGahGPc3n7wvundFUR1/66Gv0n7soCzxHdqfU/MwH3rJA
	1CMiSbU1ETK+me8UEBLmUM9Sc/0RPwWlc3mA620sGyjd03/SP746GHC3XHcVmZZ7ttDnk5zg0tg
	AkYHWcb1F4UB8NEj4RQyE64C8OYMz6YvhThvsFaJFjot6YORCZrV8VbfD2bYZGirjdNX9Uw5gF4
	8T0GbYwS0bUyjqS9ZtvQV+GItDJ02OfZo2Un5uLgvQvicO3bKhS1CbNSZ8vgQArjv4pDtBRGGTC
	vVKP+NnAeCORlnVZxq5+TrFKX6w3ROC+0LqwuJEFDYEIqjuIeMtVzMY7vQF8Y2HKwvBRwkCKZgU
	81GGhNL9PAFL4sDOUAYlz1o6Bgi34s5JxvcbqSA==
X-Received: by 2002:a05:651c:4203:b0:3ac:f258:6199 with SMTP id 38308e7fff4ca-3ae7fa698b6mr30801261fa.22.1795471619509;
        Mon, 23 Nov 2026 14:06:59 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae805215ccsm34272021fa.21.2026.11.23.14.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:06:58 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 3/7] iio: pressure: dps310: use min() instead of min_t()
Date: Tue, 24 Nov 2026 00:06:45 +0200
Message-ID: <20261123220649.36887-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123220649.36887-1-zoone.rupert@gmail.com>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

min() accepts s64 and int, both signed, so min_t() and the cast are
not needed.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 48df5a28c140..535b77da7654 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -848,7 +848,7 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	if (pressure < 0)
 		return -ERANGE;
 
-	*val = (int)min_t(s64, pressure, INT_MAX);
+	*val = min(pressure, INT_MAX);
 
 	return 0;
 }
-- 
2.43.0

