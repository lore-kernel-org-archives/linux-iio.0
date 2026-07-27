Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1A3CF054
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180088; cv=none; b=gkViA2gUg1ncs4D2n2xG/QTAD8r8d/97mDtrrr2DRg2ppG/2/iFT2CCpkN6iXHLIGvgWulqSROARI9bCCGjDx/IA28Rjlw5RP5mw0lhp+RnTil0MNYbVSOOQ2iFWaXQd1SWi9iYD/QwwF7CMkIa8MHedfp5SHl1r6mt6cb4HdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180088; c=relaxed/simple;
	bh=f/UUJEQwVW/zzZmUVc5qiSPTThaU5hzPDPyQD5pCBD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfAarwAIClslSjEuM3Kkbt1tVKP0wZyo7bOd1ydbeH2ACdFm/x5sQrgw0ZymxrlYyLQ3aRo+g1khtTDsCvxrgCYoeRmUW8TuLS1aUa0NNX0xFK3HKjo/SYljSz8NOkfhSDedfjSCLf3lF5wA9u5nP3s8JyejCzhTWiu+mxYcJAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBUfXwfs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBUfXwfs"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c998fd549a8so2162663a12.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785180087; x=1785784887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=moa1cK3lyfsCbpEdiaubsjKB+6nL5U25oPdI+VgXliM=;
        b=TBUfXwfsRMDSw9Px0AmJ4SrW8le8Fx8JAhNm4KFStDjW/URBoImN/d6LVk0LMEq+g9
         9BZqb46WWdc8KQ8VxvzgwGxujHo7nLzzNL22IoDms2kYEfVhWgzmwY8jsx2+IqWaZyDP
         4QIN5bbG3e97cLSLCrFjcaQrqmOrgryYpzKyep7f/OGLogD/Wvxw94o+V7xerY0XxVdg
         n0fTgDzsXQxTDh63DFNlAII8Nlyzpqf9vZRMLsHNXmmYI/yh+bGWzypqU5l37QAvt3JL
         0Tj1fPb4EQiMic1GO86AhoKZunkXKSGYgMr/0hSKbgtB9nqlO1tv5DfEUfIv9nbmF9zR
         PXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180087; x=1785784887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=moa1cK3lyfsCbpEdiaubsjKB+6nL5U25oPdI+VgXliM=;
        b=Zcm9fzx3Ljt7q4hlL/ygUmI7OUD4I21qdahGqLgqGbvjOo+CA/H8rJGVGbC3yxHOd2
         oVlYBdkE2XDAz2+kJP0f3doNnP5e1nNCKptm5+q914Tei3z40WptUiYrwynNDsxNlScW
         M2f/XR1EXqxE0spfODQZwAWF32nmTv0IPOktCTzopKudhHgFZuu+70ib0FUq6iZ29dOz
         rbhUk1jLyrV5zR9HSg//B+f/EZLOLDzLwMOJBIwk4CE4v1R5g/eZQMzGd3CbZEjLFrgm
         eIsbbCA93WfJnMRYTpyR/K+/fQTc49ylrASnQ2a9eA1KxTC+JtEed/BMc5glVsgjt6aT
         zjhg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8bZypkZn1bfGNbeqC3779YSOaj7t+u/KXcZPS5LDWJg80ZwLk6wa34edkiWZu/NAYZMknywRrhXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQsIk6o02XqgeCyR1S+6yPP+QRxtKMAxTInDBYUHrVXvH4KrM
	wcY2naRIYiLcQ7WnweFciJc7Ysb2jwn0nimY8/ac2jMVBQh+7l9bWnIG
X-Gm-Gg: AR+sD13IcAbDErFyFS26j4iADQqs6ny1QdM72t3/jrkTKLuhU3BrVc8+7sAz9HOxsbk
	w+2o/T2O8CZkDPGg4Gn7QjxUDr1EQSexE44Jw5XiMRiwSnStTz+u6VycJs5f3sBQdqXj6vzOyXz
	tv6Zsj+vUppjjC6MJW1jVAWbPlB0PeXlMX/O1rxDCpPbxPAoTTkeFJtYD0AdYGID4YlJBuFJa0Y
	W+ak8e7MWWyuZqE9Pshg1626XdKfgILjeOcaFr/CawpgKlcsNR17KZxq22VkdbqePL/bV3gQcXt
	C2qOK92G2FW0xp9j8Pln+l6PMSrJgiC26mg/GRXWCcA9xmVDa8JWzfKh1ePMf7aWknjWpL8YKP5
	/NwwUAqdpISrCUfkwC1uAmk0IHLiiSvz6ZB5IcffFGssGwiGF7ZAhdZJhDXushD0qQthsZB6CFU
	FlmqmeXMlBkWEls8SQ7GkZR5xyMhoP0rw9DyIJPQiHGetDMuWzXprp
X-Received: by 2002:a05:6a20:6a0a:b0:3bf:6c08:fb88 with SMTP id adf61e73a8af0-3c67e0edb57mr9634600637.56.1785180086786;
        Mon, 27 Jul 2026 12:21:26 -0700 (PDT)
Received: from debian.ari ([152.58.178.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm37595470eec.18.2026.07.27.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:21:26 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v2 2/6] iio: adc: ti-ads1015: fix PM leak on probe failure
Date: Tue, 28 Jul 2026 00:50:58 +0530
Message-Id: <20260727192102.37968-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260727192102.37968-1-architanant5@gmail.com>
References: <20260727192102.37968-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If iio_device_register() fails during probe(), the runtime PM
subsystem is left enabled. This leads to a resource leak upon failure.

Add the missing pm_runtime_disable() and pm_runtime_set_suspended()
calls to the probe() error path to ensure proper cleanup.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/linux-iio/20260718225515.7e49a458@jic23-huawei/
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9cd620b71429..3a14fdab56d8 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1042,6 +1042,8 @@ static int ads1015_probe(struct i2c_client *client)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register IIO device\n");
+		pm_runtime_disable(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
 		return ret;
 	}
 
-- 
2.39.5

