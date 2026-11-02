Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610894;
	b=oBav+FSQNiZNu4gW0DBIkzUvrZjXP8E7IP2YS/go5FuIvxYkymT7gLPOAF7NMPXzdBw9
	 f+E2ZRMxtcufY9LAp568z+OFlmF1/FblHANcyPpcdzu/L1cLsD6tkLH+purECOw0b9t3D
	 cU0YhOyI0rVFG9ej9uH6+m7NSG/kJr54UDc9IQ2WUiRix2YdtgBMXpuxRtwaB3dUHDwD7
	 /5zPzLjRrO8fs3iuhyyikavot33WFGFixKoymRIeLWIfZvTt+usceJjlM/IURszkg57u5
	 PztXSeR2Wc6z3LPe2xrsPG8xyowPbZL2hicJ+xLzW1nv9UXukftJUu4/YnzpJEMTpfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610894;
	h=DMARC-Filter:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=RiFDU2akqP6mKVPzgQeE3Cgv8b1arnpnehMfKnoHacQ=;
	b=hP4CUzOWZEQ2xFOI1gcfHOOE6Y1PGBc+9ln9SSkHCysEaXrYzRF9wz5WLl4TeR5UpUYt
	 yB+mCOgqj/Ums1tP9RGYEy4G+e9YbWgRDUFnxDdVMISC+fD1x3Zf0SNF7Smb2VSTX4eyl
	 q351qf+GydjCSoiVBeuBmkDDgfoKYX+iACJLdH28YrVGaZcbJacH4Uh68a0jaCZH3fs5I
	 EFB9RmQ9tiGY6uPYOqztMPZfQPv50UMD85kEGeKxa3j4aTyaHI7JjTe5JjOLqTCHKa0x3
	 KiuM1plwwhfd9TbylDssbgZcSFxY8IFk2m7CrYyhyb9M5UF5GwbtWWFE9CsppmZbuHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=h569ukrZ;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCCF606A324;
	Mon,  2 Nov 2026 09:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCCF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=h569ukrZ
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A29EMYS024335-6A29EMYU024335
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Nov 2026 11:14:22 +0200
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xNo7S-00Gk4l-Kh;
	Mon, 02 Nov 2026 11:14:22 +0200
Received: from lorpotin (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 11:14:22 +0200
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jaakko
 Koivisto <jmatko@utu.fi>
Subject: [PATCH v2 0/5] iio: chemical: sgp40: add funtions for serial number readback, self-test, and heater control.
Date: Mon, 2 Nov 2026 11:12:53 +0200
Message-ID: <20261102091258.247402-1-jmatko@utu.fi>
X-Mailer: git-send-email 2.56.0
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
Content-Type: text/plain
X-ClientProxiedBy: ex19-10.utu.fi (130.232.247.50) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgJAygB
 HEUDBAEGDw0aRgwNSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=RiFDU2akqP6mKVPzgQeE3Cgv8b1arnpnehMfKnoHacQ=;
 b=h569ukrZqajU/z8vnkHzuOMIg3MZZ+QBrwzZJS9IMAUy2mcE0pyqlU/mrcsu6TdhlIU9FulP/+L0
	T0/hoF8Ieh4rrzodcNVdNnrGhum6M0BPB+evM4JvycfihTRrOrStmHCd0kFWyL01gPlDSFHsheXd
	khPOiNviTO8T5izsh+2YtFa6gKASDxqdF1Rok0Y6LdOI1rM0PuyCKeVG5nwnBVGBHkic0W0rEQQY
	9BK6zgbew5DuswDnCHJsJMjiFqqRMVNMTFonXZLgzXDf3WR5uoSL9TZQo+RxXpRZNZU+LWGp2SkM
	8rmGfSwaVlYUkMojSPvYkBi9hnN5NbcPr6FBHA==

Add commands for getting the Sensirion SGP40 VOC-sensor
serial number, controlling the device's internal heater,
and running the device self-test.

Replace the manual mutex_lock()/mutex_unlock() with guard(mutex).
Simplifies the locking patterns, making it easier to add new mutex-guarded
variable 'heater_enabled' in patch 5.
Extends the lock to cover i2c communications with the device.

Fixes issue with converting all i2c errors to EIO in
sgp40_measure_resistance_raw(). Included in the patchset as it was found
due to reviewer flagging the same issue in the v1 patches.

Changes in v2:
- Added patch for replacing mutex_lock()/mutex_unlock() with guard().

- Added guard against concurrent access to the device in
  sgp40_get_serial_number(), sgp40_execute_self_test(),
  and sgp40_turn_heater_off().

- Return EIO if CRC check fails in sgp40_get_serial_number(),
  sgp40_execute_self_test(), sgp40_and turn_heater_off().

- Fixed formatting issues, missing newlines, unnecessary debug-print and
  unnecessary 0LL constant, added comments for sleep times.

- Changed 1 ms sleeps in sgp40_get_serial_number() and
  sgp40_turn_heater_off() to use fsleep instead of msleep
  (checkpatch.pl warning against using short msleep)

- Removed storing serial-number in driver-data, instead retrieve it when
  requested.

- Use the existing serialnumber ABI for presenting the SN to userspace.

- Fixed error paths in sgp40_turn_heater_off(). In v1 positive
  numbers were returned for errors. Fail the driver probe if the self-test
  fails to run, or the response is not PASS or FAIL.

- Use the existing heater_enable ABI for heater control.

- Return any negative errors from i2c_master_send() without
  converting them to -EIO in get_serial_number, execute_self_test,
  and turn_heater_off.

- Added patch for fixing the i2c error conversion issue in
  sgp40_measure_resistance_raw().

- Log errors with dev_err_probe() instead of dev_err().

- Link to v1: https://lore.kernel.org/linux-iio/20260918134019.1101308-1-jmatko@utu.fi/

Jaakko Koivisto (5):
  iio: chemical: sgp40: Do not convert I2C errors to EIO
  iio: chemical: sgp40: Replace manual locking with guard()
  iio: chemical: sgp40: Implement get_serial_number-command
  iio: chemical: sgp40: Implement execute_self_test-command
  iio: chemical: sgp40: Implement turn_heater_off-command

 drivers/iio/chemical/sgp40.c | 231 +++++++++++++++++++++++++++++++----
 1 file changed, 210 insertions(+), 21 deletions(-)

-- 
2.56.0

