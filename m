Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE03C1976
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159042; cv=none; b=fj8vGW2GmsspQYxG+WvKX30x/tsrgkPs+d7lhdxYT1L2qMQ8MV1JBsFvTDqIhqVNdyATGIGgmbsHkeD84mjkA9R2iUX7oPY80+ED4mQoasO8dq1cZF57SBqsofzPWOm/bgjgRdC90nKnpw5vag6nrIpMZVdVfJTrxYG6kYPoK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159042; c=relaxed/simple;
	bh=VUfNPwGa2375crqZ/0zGkobnkQ0w09es8kbsRO8BuKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pni36hwzBm++D1g/mDNzy6/X/BEnfIa5oMx5bcHZZfnmt7rxuMHoEFM5sXJQXP1F9PRbHwpRpF0/GLY9aE5rDGnfMEYWUm2RSIfiF7ncEDylgaqrnU7uDK/3or1CseI5PH1quDSgIZWvY9Ib7hoSr9QOD2e0y7SdwALC+ANUVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=hY/ybHz5; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="hY/ybHz5"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d96243c91fso3336400eec.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776159041; x=1776763841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awUe3e2jpc4F1xQVkktJdoRgPIx6DXz98TwiAeCpRmw=;
        b=hY/ybHz5aUbZkp6F1pDKMrR9aEs3D1c1m5WEkqPYvHcdAe9V+kg4AoGw6kj/BkSAuy
         fYq+38pZ0gZF2GxiJ1J21oM1HdgBdAWTFYEx4HQ4HahsjqYvkZK7qancMZFIQOm5eVLG
         0ix5sEYDhfq0g8ndm0eNsoTiTlBdetkNIVg8ZfKVtK9jGWIAqXxIopkCCcHQnZcGbZ9L
         2Zy6djCnrYX9g2WgU/W41IMBle4QVbFCiacujWaM67agKzQ3QThZVw2W3rmeujmqIVc8
         AhLcLb38zgFx+1mVpFWZDupGrXYyyyWcR6G7grNx9auSHCSl1gi7T7gF0jEwUH2d2QIj
         Zvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159041; x=1776763841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=awUe3e2jpc4F1xQVkktJdoRgPIx6DXz98TwiAeCpRmw=;
        b=GMLF4/6BZVD1PkHwUvFKcPdCwPSyx9vMM+AXv9hXJ7Q2g96BxVbWi7RmyOoWGIpmAx
         UaWe9o/se5stBws3bPYbcx3nLdRujd7xe5C/WW25lGA6iVwaii2L/Nf2BzfJEwfae+8P
         8IvEoJ+Zp58o6/FG5/EcbxaclC/beUb1vs8mRKcMWFycjpCQ6HMetwGmrUPNgSegjXYm
         bZKlUJuqN2o+jEPOvsDjbkWNnlnmFDLpKvT8wIlNtUHuDP6NECsbrzjbdSD9P+F81FmO
         SV+GU0mkdkJvREzvpv7cD6lfNsAXujyDb4B9X94zMeE//nTfyuJyU1J1rPkHFh6Noklh
         i0Gg==
X-Forwarded-Encrypted: i=1; AFNElJ+ciARIhZBGyMR7VmIRgfNLE9mhALvS/y5mw27qRFWK9DT0Gp0Ne0yclcMT0beerJcoj7knEX6DeFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQyWcNrM9qzvgdUszsxz5H/WOeMeideCu1tRouF6UmI4SvYVOb
	DbzIPGmSQPyPTLdYCpym6S80bIlpM92jt0S4pLEp0tfR+XNLIZkXzaoj85Mk4iFkXQ8=
X-Gm-Gg: AeBDietdaLgx7kZ3G7MuAmAFgn0txshPz09uXKEzgppJUI/ieTGt59EAAVMLeWHRV+l
	o3aR+PIUj/HBn3vvDZ+Y2Q8vS8wSHiUFA1UWq/ox0yxzKp1usefLo3nlYO/FRDk/FHcM3Bmr1dM
	Khd5t4YWWBfqQwcXUDzVAX/7o2AXfKt/8YOqyiSVdmL8eBiloDG4CmRbJxXhKNkiusJPKjVBO7z
	CNXZehEwOc3nWI2soGd3qDAv0pPLI6dXlzZ1BQLHvLW33725g6pzFRT90nIAI0Ixw66tIBFc5lE
	rmVqmnQx4dWw/yazCD2fpFkpm4nau6epW8cOCJLWo1w6XBlblRUafo1fO2s9KSINZe5MM51GN+/
	bKhc3xOCux79Wj/fuOnIMW06JEPGSI7laNdQyz0TCcXGIidIAiTW3OvpEm5ClodjyPkRNoZlRxK
	qQ2D6V1yvaiP+Gb9Y7+QrlN/xxPmhzBHYsQAxlvRlkxhyKhPYBN5SwrMwmmyiEPoWiSlEU5FHHy
	iWR4GbfyDxNfglBENY3GZg9cRUE5I82ymqn+VAlIKrxQtEyLQ==
X-Received: by 2002:a05:693c:26c2:b0:2d8:7302:d21 with SMTP id 5a478bee46e88-2d8730215b3mr3347154eec.16.1776159040566;
        Tue, 14 Apr 2026 02:30:40 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db6ac8sm20327599eec.26.2026.04.14.02.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:30:40 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Subject: [PATCH 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event handling
Date: Tue, 14 Apr 2026 06:29:28 -0300
Message-ID: <20260414093018.7153-2-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414093018.7153-1-guilherme.bozi@usp.br>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ams_event_to_channel() may return a pointer past the end of
dev->channels when no matching scan_index is found. This can lead
to invalid memory access in ams_handle_event().

Add a bounds check in ams_event_to_channel() and return NULL when
no channel is found. Also guard the caller to safely handle this
case.

Fixes: <d5c70627a79455154f5f636096abe6fe57510605>
Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 drivers/iio/adc/xilinx-ams.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 124470c92529..f364e69a5a0d 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -871,6 +871,9 @@ static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
 		if (dev->channels[i].scan_index == scan_index)
 			break;
 
+	if (i >= dev->num_channels)
+		return NULL;
+
 	return &dev->channels[i];
 }
 
@@ -1012,6 +1015,8 @@ static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
 	const struct iio_chan_spec *chan;
 
 	chan = ams_event_to_channel(indio_dev, event);
+	if (!chan)
+		return;
 
 	if (chan->type == IIO_TEMP) {
 		/*
-- 
2.47.3

