Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913790;
	b=cfzAM4Z64LSw3tnyvlO7162s67cGhRIKWp9Q0Q06lgBZa2HCEzYG2IILsuGulB3L5SUM
	 5HP3UWzcLgTHLD+roWExM5lAFoedDSoASOJiXwDrg78G0I3zQwPGaD/gVrb7aBMI7UVGy
	 Y8Z8wVDnw2E7jSyTXwjxFnqWd9ggheEGl7aqQireuRvli1w0o6n6h2RFf8ibHQDSLKSIF
	 7hGhNdX6PuO35qBed62Ypfg2EVmISbU58+mPvqRYNzXBoz86hgGGxGGCn91visUlNPIbe
	 xwxbO8Hj8X/8LkLWx9XkVs+mTUFTUC6asOp2Zn69ngsk1TzbUlonB9HyLDoBp97/3cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hpmM4eFRun76lvi2NsX7aNzz4o3nnQQCjWbpPZyMB+o=;
	b=mkqlcfn2W2Sp/eVYFUWSJ6Ni2Ue1+g6bjiOidRB7ClZSqi2uZlRj7do+aQ3g4psYDXYA
	 ZPS1iZVF0AS+d1M2kH4qmiM1ERQVPMAEFm1dE5o0JCWq+1cbVDhHw1hyjv4hgklDEWABC
	 artDpCVWzSw/mIHYoMpVlIVpU+mvZ9Hq9ICCDxkXNKDH5UhhekOLvGt1SH4wczbltWy5n
	 XvYyIoTcLq5dNiNLT854k70eK/EOIQeLdw9uPZSyjrNPtDy0pV3MdyoL2w1ytHalnwLr7
	 0TAixL0/l3IuwEUcxJUO8YjKBRI3JN304kj7HXl0+i8hRhGLyirjmPQ6waqFkSF1gLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MD3kGh8N;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC8606A331
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61AC8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MD3kGh8N
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3791619605cso8151861eec.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 03:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913788; x=1795518588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hpmM4eFRun76lvi2NsX7aNzz4o3nnQQCjWbpPZyMB+o=;
        b=MD3kGh8NkCjvXmoC1i4w2PtRphlsb24xAOL+9ggH1ZTFw0LQ6UvUoCXyiAzNaJp4/u
         6xwiO6o780CNXl7+Vga8jetTnOWcpaQra54nhden1ttLqc2oaMawb2LTaCTQhmiymPsV
         G24D4X4DmnUlcs8CYBjq4F4HGAYoKvpAuEe/IRJaIR2WdQKHXYUxk64Ceq9dUnA5mDwP
         WOcCwdEHVLuAWzSPRUK6sN8TvqE6G8LKtHNfn9TyoJjv+RLd6gss4AATY0u+4J6N2+rQ
         h7I/p+m5/2VBSQjS+Fcn45nyrTJpXD1qHAtWPHqqep+oBhuF6iwc+CJ5Uiogkh2Y1hqA
         l+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913788; x=1795518588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hpmM4eFRun76lvi2NsX7aNzz4o3nnQQCjWbpPZyMB+o=;
        b=E00cgfirsQf+l7s3WX8Ptju6R0K9Jmdk2/nAz4kdYS02wq1N3XVb2ZnUsC+kByTUSz
         WBLKD1F8+bV3gtW6s3UBl8jLnJ9DP1hLG4uRlgb022X1IGtev+VBeYTjvkLWgIGggZW1
         5ykMRghZ3U94ANmBwfIeMBM5qV6fTHtfxQM9j0UneAga/iLP5IH10mWliCa8pyuyzMSa
         LiTLqVVSXt+Boe+77QztyFP1uzBFjxV4xVK8XL892sJVYfq3+/CCpxqeNz2/dHmeUFee
         khfHHPvyAJQxo1afCw+VPSb9FSPxYxdvH2n8PkqoQeIjx8jFLKHpeaRP8NsyHqe17cU7
         wNbg==
X-Forwarded-Encrypted: i=1; AL+hErEbqYUw3cE3AxsSfxrDxQ0dubZ8bjwQUgM87vNmMdJIClIdCQUuNvped3vKUEvBvcsMSs508/0jGcI=@vger.kernel.org
X-Gm-Message-State: APuU4Z84oRJm4bq0HF+ERhHJgcnQv5fIkLMe9PY2VipbR4aIMoznxx+s
	HI/Inj5FpwfDa9saCZolLeMsY3T1BY+7Mk1lnQGK48gKv4j6T8dKqlrO
X-Gm-Gg: AZFdTZdIC3nsI58clhr/YX/DIShqAbtQARVR4/+ab7e2jq4SMQApLpDNk/hM4Cef4td
	Vx9ndIojOjW80YcEAckQ6GBq6FFYnHxSBTdFNzzcHtP3T96Jh2ik2LhaJlisOo5Vxx8jg8zrJ+U
	rT4sI/2N5A/29CHRLeWvWcM7qBEqldvmNBxNFE8DY6huEqaNQW+frRzE6+rqrF750RnNikUWgF/
	854ACP9e63gkoBtnPV6V6jRepjO015KQyqgnyaXj14MVKH5c+6RamgtzStWj6JIiHkdQfZm3EXq
	11xJFX+Q7uP/7akxa9tHiIFblOSFtM1fIfQjVt94FZH+pf+iNMNZLM3DWeo6qeRePVnJNle+qfu
	OgMA3wkcQOLJWg9YrzqDnt2V4fMt2m3v7OV+kfyuhHeefonDJbDFZos+p9er5VKmOMbn3WRXnjq
	OfmaY29n3MTDDlqGpHnvbSZMjvZ26BYtXgAAEekLLgO0l+wfxzSIevWnquTFzjQmzjWCaQrmZ1Z
	T44MSAZx3fLsn76GvlsukaN+JoBcCbBR6DHXNuHArTavYIXtYNcNacRCW0sdQuSjEwPTSg0rYAO
	DWlzcr7M1NHLl3PUMUI7uO0+gj+hIkR7IL2xmKiJ+drFQ9pNPCcZgA3dhobHkhvlSwsZG4vJDCs
	4Wk/jghoX+Tw8UczzKh254Qla5p/Kb13n92exvnaXY8u8F+4rlI3z76J85plH01yvCjAx3E6xPp
	wxQaDQJGHk1CoJMZ19WEv9AUKq+/PeW40nAk6UknsTzw==
X-Received: by 2002:a05:7301:70f:b0:381:eb93:81b9 with SMTP id 5a478bee46e88-381eb9383c7mr522846eec.34.1794913788282;
        Tue, 17 Nov 2026 03:09:48 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-381a55555dbsm5560475eec.10.2026.11.17.03.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:09:47 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Daniel Campello <campello@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 0/2] Semtech SX9xxx: add a reviewer entry and binding maintainer
Date: Tue, 17 Nov 2026 16:39:33 +0530
Message-ID: <20261117110939.214932-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add a MAINTAINERS reviewer entry for the Semtech SX9310, SX9324, SX9360
and SX9500 proximity drivers, and add myself to the maintainers of their
DT bindings, as Andy suggested on v1.

Changes in v2:
- New patch 1: add myself to the maintainers: lists of the four
  bindings (Andy)
- Patch 2: refer to the Link: tag in the commit message, and use
  sx_common.* instead of listing both files (Andy)

v1: https://lore.kernel.org/all/20261117094737.15253-1-kapoorarnav43@gmail.com/

Arnav Kapoor (2):
  dt-bindings: iio: proximity: semtech: add myself as maintainer
  MAINTAINERS: add a reviewer entry for the Semtech SX9xxx proximity
    drivers

 .../bindings/iio/proximity/semtech,sx9310.yaml      |  1 +
 .../bindings/iio/proximity/semtech,sx9324.yaml      |  1 +
 .../bindings/iio/proximity/semtech,sx9360.yaml      |  1 +
 .../bindings/iio/proximity/semtech,sx9500.yaml      |  1 +
 MAINTAINERS                                         | 13 +++++++++++++
 5 files changed, 17 insertions(+)


base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
-- 
2.53.0

