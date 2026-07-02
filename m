Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468038C2B8
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019873; cv=none; b=mV4lNilOh/oMT0wPi3abAwUEZA3XyNDo2EkD1S5hplmfRMEt2T7kbTf6sbQiRRjTMPvfHj36E3UQYOqGVM8iUaXT16OobzXt9vWxSpGHR/jZm6ZUEjq5CuoZ912uFCn3IC0UVl8Xpg+BWrpscOhnktsFIvPJamyt2bPdhLswycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019873; c=relaxed/simple;
	bh=M2X+MxkNRXD8HBaLcQqbawfM9t7HcYXzBLeFoOTI88Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEiOyCbg4lw/bQzX3Nda1zASZ3fCk77iaOjK2rCEEhp6gmYtbWqnPCjd/3G57GiefR8rEP33Tsa2IJ2fBCZydoqIFXgtpsY4Mutpq17Gvnqdd4/wWxVxe0C9w5friX5OzFEkXe0q45cil+xQ+/veG7S1OqzxKXgNHT7eUYyPidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7B72y4m; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7B72y4m"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c733f15aso7371915e9.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 12:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783019870; x=1783624670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2X+MxkNRXD8HBaLcQqbawfM9t7HcYXzBLeFoOTI88Y=;
        b=c7B72y4mhTmw1oNeI9bvNrPSKPr1a/DPRhuiFYWF2JU2AEy86Dtn7rxNgWflb+4r79
         4NOFEhrg/WwnhSJ617O5Xt1mljOt6u4KlYjrR5LajSVzbnGSiYedNzqds0/fZYjconlr
         aUnpHlqxRREsk0372ghFAzly6WmQfz1enhpErGGzZz8qOlr1CWCu4asjUlzR8FlCQK6y
         VSLa8ST4zr5YzNU0/O5iGCb+rhdwzARfZfG+NuC4q5/M6sPM8xQxWx/zMqisgtMlbUWw
         VvPnnABkFg3nwgLOs9Rz6XBosSu09TZY2Sv1RGAO/K9oa1i5uFhR5oQn+BnYUToVP0/E
         zOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783019870; x=1783624670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2X+MxkNRXD8HBaLcQqbawfM9t7HcYXzBLeFoOTI88Y=;
        b=ldyhQfRxkQhAjaBHkyX+Rsxsr5Y6hi+UaSkHl7SPN1Muz3CVs5pRTtU7SIB8V08WTY
         /GT02nqC5oSzPaEUMOfTifZ8L3WS9vMN3OlbBOCcguNEHHL4OIHGSvwkXXUZ1Hpuq9jt
         Vn6h6mbca6ukKNpFHJpteNSvMAj0mzE52WQcjZ2FEDKsa5lKZfMxMsnIM6CqGYOUhKiq
         DAj8UJ2mdinO+cUGkEj4QM0e+EKASMgwkihAtxGPVSAGFZ2ImNePXdY4G9QkImT87Zod
         Dqu6kuVcoOk2/ARYHVG14Mmq5KxEVSPXaUxWlvWor512HS2E/yJNglZqTcXHQ70mDt7u
         0rwg==
X-Gm-Message-State: AOJu0Yz5fwqrFl7b2cY25LGFXh685Ipzk54ibXBDYG/5PejCYU8cX6x4
	w3giuUlTd3IIzCkCGYY/6fn3dfqmrh2g3pHuVoQZ/6AB/TJTANXK3Tcq
X-Gm-Gg: AfdE7cnkpO67pN4Y6vTI5wdBVSxa6CEY1goNiqw2K63lWx+UajPQmdEyBkXcdL2lLA1
	mia3QtaPq6u3OAGQOT7zqAP9ZTJA7N0vb4rcN5JRZdP7a8MMIPn49Jb+IHqYmi36QGtuirO3Vwy
	QVws8/FAj+HokAgdztqEBnI2EEwwfw2keu5Hoxrx7GhqJSJ2H7ZtnbWf7J09G42jqoVgo0lPaKz
	MUvRDToUTPjgxZMudy6PYsUiBZBTkIwBuYY9PrvcKj2Tr5bFElY0rzrNOsJjaL52hw/8KAriZJJ
	tgqV70iRnBChkJOgGUlujaLzwAvgMo8UbT5KJpjkj7pAzzpKOA15KZ+0Q47hKwLNfmw9Oo9U45t
	FQVSRKEJrMm8me4bySQnVcgnU6TRIblqPb9jYxxgba9IgsFqQx+3pdXgkGa3X4kzRFNzDbT9in0
	2xNd5kw1BT8JCNsAXQrV8hDJFnFL7zJXr23pIU4sqcTI4/ElDao63iXDSunXiEsk0GoPues5wqh
	fmzMw==
X-Received: by 2002:a05:600c:8590:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-493c2ba43a2mr91579975e9.33.1783019870111;
        Thu, 02 Jul 2026 12:17:50 -0700 (PDT)
Received: from arch.lan ([91.230.98.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6368f89sm64678805e9.8.2026.07.02.12.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 12:17:49 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] mailmap: add email mapping
Date: Thu,  2 Jul 2026 21:17:41 +0200
Message-ID: <20260702191744.118898-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702191744.118898-1-tduszyns@gmail.com>
References: <20260702191744.118898-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old email is no longer valid hence add mapping to avoid bounces.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Maxwell Doose <m32285159@gmail.com>
Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a009f73d7ea5..10a2e4f8fba7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -861,6 +861,7 @@ Tobias Klauser <tklauser@distanz.ch> <klto@zhaw.ch>
 Tobias Klauser <tklauser@distanz.ch> <tklauser@nuerscht.ch>
 Tobias Klauser <tklauser@distanz.ch> <tklauser@xenon.tklauser.home>
 Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
+Tomasz Duszynski <tduszyns@gmail.com> <tomasz.duszynski@octakon.com>
 Tomasz Jeznach <tomasz.jeznach@linux.dev> <tjeznach@rivosinc.com>
 Tony Luck <tony.luck@intel.com>
 Trilok Soni <quic_tsoni@quicinc.com> <tsoni@codeaurora.org>
--
2.55.0

