Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9042C513
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702743; cv=none; b=DlG0CoEDNH85vmSFWLVMomYynzcJAQJzP8KtCQPWRfFWU3RXfd5lx4MyGycZTq3SP/2CcCShW/grmJ7RIe9hhK/Spr9QaHPPVAmlNdtXzYcnjeseJfBj25C3Wv08VNBDg7BGKMBLEQsXt8rclwCbYY/gro1AX56iqie0uTDLUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702743; c=relaxed/simple;
	bh=FOdesGdaNXou5XkibY6IgavdGaoop6u6/nm05YrFSs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhrbleUl342Ax7rFbsYo3UxZel2TS0vhekm7goQSTN9VdL6LtPnXaB/hO7+7FvDGTE0iKUEBlHrjmldRDGlPPri7G3xNAAmyL8FRaQgUD/UajlUtw7CpAX1X/DVX6MXKiY8N0hwOx+Gd/f6Dz63Mil2EXhIf8o5/dhm4ZaPUBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgthFY43; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgthFY43"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e08baf860so842264a91.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786702732; x=1787307532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9uLQmEFa+VWY4gtZ+cCktBxWWCghykwU0UrqU9Ae1N8=;
        b=dgthFY43nKN1kPqvZShVBNp8JiXKVDuP885S/Gqwp83ilI7qGYZus2vL9/vE5dLvB0
         dzIlXDS3MrnwJWpAsMmRyk6Xhy0BKZ4eDlR/xWSLiUsxYWeymwdCbIyr3Mvi04YvHo+t
         M7sxvtc7KdJFBYpIGYqV4VUqbE9yfJZWbXuHeiyGYJgEa4B7jUdBuubLBzC1CtKq4MXV
         Y5ShcumQvU/8xLwdTsNHDEamRmQfP1CaMCZe3h4OkSTteChhwVFZmZqNa/kmEEhJGhp1
         ceGhhPfXneY8gc2P6i7ZlSNhio3Wl4DrbnJzuW+jQTXRY1YotFxWefAQon9MXVa1fKCg
         /fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702732; x=1787307532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uLQmEFa+VWY4gtZ+cCktBxWWCghykwU0UrqU9Ae1N8=;
        b=l9Fcx0rQ5o8M57lOCndYHVBW6lr5VK+pEd6bArf+rUDOMkGtBpPLe/FA1KXqZkxZzj
         xUxeZW7w1DP4W1qGm/36a4wncPfZKPjpyWBYdzfkjbESyzvxyoyfzt7dDAJSgL6XfOV3
         7j2Qdv/fUdzn3PMWyQhYpy56gZxLNjed6OQSvQB5ne8g6qs9LFUNaHGGJZQeaAIdfPql
         g4vOASuspMW3zw7nPl9w7RLAbtXVm3zZc4UgkkCkv1a56HaBAvlNHVRchq+3bfH6CiY3
         fK28oRpryRt/rSERLUNgfzbuC3qU/tT/33rpXvG2+6qxTarA8wElWEWPs7yMr5AmwEov
         iD1w==
X-Forwarded-Encrypted: i=1; AHgh+RoNVGriitoegUEy1h0eWDWBl8+0ctr6TVo0yijZZ6TOb1NClKXdq/gZpnmW1tryzapbEJFDxddCvqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdpHJgu07WYAtPfhc4moMmbPpdrD3gucLJBdcqR03iT5OI4oGF
	8H+JjudSWin8Kb9BPsauPXO4pSW07fT+MIbVEna6h7cWEtKksBsDgKoK
X-Gm-Gg: AR+sD12LbuJXopEU0uD3JkbBoOz3Dh6nykK+lDPJINug1lhoe+W3EoS1DWRmekIn7bG
	P4t6oC+ZnkZ+JiBV6wusgAGB5JyA2CO6FIZP4jgDtPVHTcbLxpKcRCG1EoKwpZOa7Yd1bpQ9Qjj
	EMcQfVu23KnVqSlAa0e58tPS//kA9w7MbcqUXf0xe0tTBa7u/Ix0zE6ReuGEEIFfrlLm0cHWUvZ
	i+1hQxsNzpin1SXycjSlAeRIbWvbLWMraKPGA0nCqJ567Kp8sLZYJY5TAGqolzzRchp8k8knsA/
	hOhmS1FUHqbklkXD08soMNOxsC1KvRA75ZZ0MIh2X6hgq8c9sepVdpdzij+ioqwu+mY+94KsZJ6
	vVdQXUXhkSkEKXtJYfrZpJkRtWmriQptrtZ6IMclD7AH3hi/0Lgf3I4yA4gwbO1U8HVr7AslHCw
	Th3/9oqoB9UcRHZuXlLC5QuXXVCS+KQwLIPncL76S1nO48QdjNuaiHSFYeZrA2caJDo1sm2LdXV
	B1oQjcj
X-Received: by 2002:a17:90b:5624:b0:38e:7f1b:efa with SMTP id 98e67ed59e1d1-3933e5c4f30mr5205423a91.11.1786702732409;
        Fri, 14 Aug 2026 03:18:52 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:124c:2e49:6997:3d3f:909e:c279])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e920ba18sm2074218a91.0.2026.08.14.03.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:18:51 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	yashsuthar983@gmail.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: accel: bmc150: DMA-safe buffers and use iio_push_to_buffers_with_ts()
Date: Fri, 14 Aug 2026 15:48:41 +0530
Message-ID: <20260814101845.301769-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trigger path used a plain s16 buffer while the FIFO path already had
a properly typed scan member (__le16 + aligned timestamp). Those two
buffers did the same job, and s16 does not represent little-endian data.
Drop the duplicate, keep scan at the end of struct bmc150_accel_data with
IIO_DMA_MINALIGN, and use it for both the trigger and FIFO paths.

The FIFO and read_raw buffers are passed to regmap bulk/raw reads, which
is not DMA-safe. Move them into struct bmc150_accel_data after scan and
aligned to IIO_DMA_MINALIGN.

Finally, replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts() so the push sites pass an explicit buffer
size.

This supersedes the earlier standalone patches:
Link: https://lore.kernel.org/linux-iio/20260808220236.421832-1-yashsuthar983@gmail.com/
Link: https://lore.kernel.org/linux-iio/20260809111303.496393-1-yashsuthar983@gmail.com/

Yash Suthar (3):
  iio: accel: bmc150: use aligned scan buffer for both trigger and fifo
  iio: accel: bmc150: use DMA-safe buffers for regmap bulk reads
  iio: accel: bmc150: use iio_push_to_buffers_with_ts()

 drivers/iio/accel/bmc150-accel-core.c | 28 ++++++++++++---------------
 drivers/iio/accel/bmc150-accel.h      | 20 ++++++++++---------
 2 files changed, 23 insertions(+), 25 deletions(-)

-- 
2.43.0
