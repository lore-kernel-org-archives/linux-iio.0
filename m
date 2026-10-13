Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220C3F6C3D
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911855; cv=none; b=pcEu9ENCRa/1uSj1Apy0lkeCTfxUv+rRgeQSqepi7TF6F+rxisW3MzDFhGxtaYp0DYnO04z8GNMFCuQI33Te/avZ1RjHvcYG0n76QhI3aBcGb5/HNEBYqo8/T7YO4swNeBIst6DaktTPcehCSIQcvMd4gdKZCOjeoen0EUS5GXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911855; c=relaxed/simple;
	bh=+4OV03i0EJVYJAj0s+f12i9tbSSJEF1awclvr/932vA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OVfQEGcckIJCXKx3owqIBiTXizArksDUCjv9fekcO4udFfRfiMupLGLpTka4s5gtWKi4YeJGEFiatMnFhwiZmPV7D9NzzvkUspqrfAY2r5zKJ7844+ihZ1rafNU4f+ebYXQN7tDwJ+Qk0iWXFMov5vlu6ZdImzNcHXhpGsx9FgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slmVQe3v; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slmVQe3v"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1517bda04a0so2039504c88.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791911854; x=1792516654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eattSOlERH03Tw84P2kHaA8gAf3HFT+7yXhlaXTMwtg=;
        b=slmVQe3v1rYwSkRLjiT4tWub0gGOGc17+s0M8X0PfvchWOFLWdh0r9CZ8Une7c3BRj
         kWBu6AJMioYjmIBf7GVnHX8WIgdjv7hmB613PX9jc2GL4AgGMWHHuiL1z4AVW+5m37zJ
         WPozao46eixgByesANgDBkoyz29HL4I3kSVgLo0Q3hTrP6GjoYm2EK9hLElJA/78XR7e
         S31a01NKsflVtDNAO2w/yGsHkgB7I2ZuC7qJANtPn+4IqL/PjsgpH7LaHFdgSevB+z7r
         oKvih9yQYgmy78e6RHs3i1OA6CFJTXxBNvGKok2ZwR2gQ8TROTEA2ANVDoSrRRBZolr0
         GF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791911854; x=1792516654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eattSOlERH03Tw84P2kHaA8gAf3HFT+7yXhlaXTMwtg=;
        b=OLNwyxoPsiDj2/voNJgn6JvCEJWLg9c05E6bhH3Lj3x9G2hYDHeJ2JCA+ErRU6U+3t
         krd8HVqKL4GxyZfDM+KR9e/X90j0ovQgPoeoEUFvEBzz2z28OS/5ws4/oAoKP13lwWRJ
         R9++R7b4q6n1QY/Z7dBtUcMx8jKzjIbQys+HhjVFo0eO8A3xOZ8Q/r6qzrf5Y+FdBZvw
         FMgfEwOu9cSpsqMtDlT4iVbV2sKVWWfJODTOA+cM6L7MBOMRMswtvzpkhtfXtW8A8Rr8
         9n6PpNxQAKnwLwPqZe9+AadzadSTA4F43kmpEV2x/f/2u+1DhFB2GK221GUyonCsxtfi
         e2MQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBLvxWxkyvJVEgmlLKJyMiqO0W3Y+WjuIE3bowCP+QY6NV1/PK4/yfqRni4w3DzM5K21fOAo5P7Vk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL59txvpCts1G8cehH8w/HlRc94sIKXpfMpcTytMbLXnfeK57iU
	JazVijGdWRe0cZyTj969Ce/TqOqDPi8OqSkUIRYf0FdpBChpZaQpdQQ=
X-Gm-Gg: AYBFou1DrbgeHLSvN2TQhoPLEgw+fHYrYH1EtOE5L3Uw2nRYYZOi0zsinX6+OvU8HEK
	dUfvfbd//HAmwUkpxleCtIBwY4haz1JfAHlOv8qm3QKgY3iXrjaRMuD3uoG0oW3GBrYwNsZMh1/
	fTPaSEYkSIVHsNZ3murlAJ+Gjlfu1atX8uhGXnh73xcGBJVROX/R1MJcqAGhufDmyGmyAOQ/vuo
	qNOcd4ZdeK4ARShmPcEDcIMVw/6qQGrNhUoRuoAJvAWa0Xg7smL0YzmYSorNEUnXP/jWw+Ro7Wm
	YTiR92E6B09+SCYWcTzUI/t1+6LLSefB7ZYArkG7/CMUibUGD0LbP5LvzTlJk/rL6qGZnfeo83R
	XbuwaCslhogcmi+5WkgdC7XP8WtrN8/jy2X047CzAspd5c/dl7Md02bc36UOa8j9DaITdCDKjWf
	YUDniBSoZdM8/einfby2b8/oFmlpq8VSggDVOZM1Om48fdlBRJsuCkfGNzBfXMgu547/UcVYsJ2
	7xO3VAsUY7lHg7+HZbLnofoJB5Y94LbYcHBmg==
X-Received: by 2002:a05:7022:ea8a:b0:166:3e26:c4b5 with SMTP id a92af1059eb24-16a5bf3ee1emr16409864c88.18.1791911853663;
        Tue, 13 Oct 2026 10:17:33 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm47268839eec.21.2026.10.13.10.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:17:33 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: anshulusr@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH] iio: chemical: ags02ma: Check for short I2C reads
Date: Tue, 13 Oct 2026 22:47:26 +0530
Message-Id: <20261013171726.15670-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that the I2C receive operation transfers the expected number
of bytes before accessing the received data.

Return -EIO if the transfer is incomplete.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/chemical/ags02ma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/chemical/ags02ma.c b/drivers/iio/chemical/ags02ma.c
index 151178d4e8f4..2219965d044f 100644
--- a/drivers/iio/chemical/ags02ma.c
+++ b/drivers/iio/chemical/ags02ma.c
@@ -61,6 +61,12 @@ static int ags02ma_register_read(struct i2c_client *client, u8 reg, u16 delay,
 		return ret;
 	}
 
+	if (ret != sizeof(read_buffer)) {
+		dev_err(&client->dev,
+			"Short read from register 0x%x\n", reg);
+		return -EIO;
+	}
+
 	crc = crc8(ags02ma_crc8_table, (u8 *)&read_buffer.data,
 		   sizeof(read_buffer.data), AGS02MA_CRC8_INIT);
 	if (crc != read_buffer.crc) {
-- 
2.39.5

