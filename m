Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA644A711
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502674; cv=none; b=FZhMbDAsG+xcbThOjEKUYQeK9kPXrbT/swtI2kRjuA57en3k1GJhPSuW9tdQZSqbfXwyWBKLzroWpayji2S+bwVdCXI7mg3gfUs8KkPq+2rZDP0ablKPE/Gk+2bMM5ui1lOoDmTRN1J1GxPgvDdcpJsGadW7PjcrOdtpaHNxktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502674; c=relaxed/simple;
	bh=NSzAhVDH0vi7qJ0DvlOODldmIdjn4jHM2BAo8YOCZnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M4jWSLiN/lAH8/yi0+1dpNr1Sf+Wysar+7lcO23vhsTJxo1j7B/c9HaZy0ulYfF/rEtAE97QEfTV8fBarC90in5kWuOK0Ms89mR8qI1FxDR3F1F3ygx8JcVFkOUmF4ktOn1hEay8z1Xvio24sE6J6oPdiFykd3na6OcAnD/SCd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ikPcfWjw; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ikPcfWjw"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so875658eec.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777502668; x=1778107468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Czp7cNxaF0cZdiRPvsVGybeQesu1WIL0n4WulRaXg1Y=;
        b=ikPcfWjw53XPsoVzTynw/Adr+hcWmppuTwh7j+v4QPz6v+MGO00L1u4EUiSkygLT46
         BQeKK7k4zD+qZRVYuX0GCJiM+ozE8/iOe7zBBgegd6uuYT+6+2VnwUHstnGSLZGYKx/G
         VXUIEgxEtqbvxNnosh06y8+Iu4sAbrML0ds0e9PM3NLFLIQz9K/DwPTLO0l0QACNQ526
         64kmYqZHPhNgnJDGxGGXVlS0D5gdlts9TGLhKZ87Plc7g9vDDTiiTU6zgSgOn+7lCJA2
         yKV8IJk8OOsJjBYXNHhdnhRbj1mszpwqMmrmvnm6V9NSMi11KM9mOb87TUsJG9JzA9Ki
         Y4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777502668; x=1778107468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Czp7cNxaF0cZdiRPvsVGybeQesu1WIL0n4WulRaXg1Y=;
        b=bbPpWIUz2iv8BcY2QYpwgOTiSWNi030InOLNNRvml6+gmSJkNMnAPS7qwaAvDPAxKj
         XvVF+OZz0cSEL7N+TB7vEx8QplCZrgAtfUfb/FXDgMHj3Qbwk2XyDdMfQqHtPwZfZX09
         Rlw0lZgDsr9XoYZAApPt7rVijTiEW2DcL5opBEFAXc44dMEe6xN/o0kTAtZIbBsFHko7
         rqnpofiiF8l3N3Y1Ow55mws/HpwsUtsz42xfCaJhM7CPEafcQslg4/3ruftaBK/MrrdN
         qX1hp5KRplS6afAFRDOhoW+93meE7Ht15Dd4JZbsafn5PdlbK0FAocEoC98pKhoN+2kC
         vDNQ==
X-Forwarded-Encrypted: i=1; AFNElJ89nnSJZs0BMeih+ED5End9BGbHO4vAWF1e3Vn/1+9QhA/LRcFyphHM4QEnudAypces3gVAmEakBEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5UkS6XpxDf6QXIC+gAsrTjFn05ePjdngRQs3A5KZJeZJzfVR
	1bHABIWuvb7gmS0t7esc3zBxqyPMjxusgLFRRcO70aMoBkw/un/VucsW7Q6KjYryAcw=
X-Gm-Gg: AeBDievZEepkX+EmmEFSk9UYe4RKsfk1gmtNFSbUOy7CM1WVbYD6OzJMBEIda+KXMZM
	oBjXcpcIm4/MIlIztmAsUIjGwUdxS0QnqcM3Qb0Yx9VtLAQ/ANqzGNuD2gbA4DWKBWq+u9nQIlr
	0iCj/IvpSJjyOTPqGEwZxfX/NDSDkHjBkXscHHHHeoFBk0JcQIrylPLGHCuzdF8OzihAtYygatp
	yXOzvydOHjMThkb2TVjHkddGG7AL8qY4te1WWJSp0zleFTYkB2XKNSi+oU0mfK40KeYAeUFeOXs
	j3cFUP0iGYSZNyOJlY3L+EojE2oQhlDOccqe8yH+TEz9no5j48lI/cpx8oghM6ijDtovDB9gTGk
	V3QBSRL6hKmhEW4tqlLMwSCdsOZadqkTuBFSSSavN1AMSl3jqn4/lwOz627PA1A65QeTUkmWsfI
	Tv0kmsOXWEjHdRzd/YjxOdjOhwynC67hXnrAtufEF7Br5eWGWyKAoCerRDXMGc
X-Received: by 2002:a05:7300:a14c:b0:2ea:ed29:5a68 with SMTP id 5a478bee46e88-2ed3dea4ee4mr117090eec.22.1777502667973;
        Wed, 29 Apr 2026 15:44:27 -0700 (PDT)
Received: from avocado.. (mvx-177-92-77-170.mundivox.com. [177.92.77.170])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf6d263sm4238222eec.5.2026.04.29.15.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:44:27 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 0/2] iio: adc: mcp3422: apply bit manipulation macros
Date: Wed, 29 Apr 2026 19:43:59 -0300
Message-Id: <20260429224401.11818-1-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set rewrites several open-coded bit manipulation parts of
the MCP3421/2/3/4/5/6/7/8 driver code using bits.h and bitfield.h
macros.

Marcelo Machado Lage (2):
  iio: adc: mcp3422: rewrite mask macros with help of bits.h APIs
  iio: adc: mcp3422: write bit operations using bitfield.h APIs

 drivers/iio/adc/mcp3422.c | 65 ++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 38 deletions(-)

-- 
2.34.1

