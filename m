Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200882;
	b=rkJBEhCoVaezSaZ30ErUsZV/jSKUxwIWz6EolNsPgdJwOEMW9FuiA6ZcOzrzzHZ5BjDC
	 NFNw+47xCEZI70oUyDBhj6cv80n4oORmwhzJzXaM1EWQnHHmvRT0X4h6pPRlOrnXfU7lS
	 Evow07JD/TjEg1PsPN1G3w4dJuJ16QM6TM6FiK7wNzot8d4LZ689ZQs1bjZhAqQ86kf2H
	 XGimyTqML0P1LqAV8A2kP/L9vXAUcmYXP9fr3PL3ZSO6BULjRRi1AsttVeGaomgyw9bOt
	 85nIIrbvSUZ6KHIaSorHFSdQj0cqfXa+BWJW7GsAjWh3Ur2hjyK6d//3fUCvXdKtfsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200882;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MIME-Autoconverted:
	 Content-Type;
	bh=82SmoDYlovGPPIZPAG07xavpSWWmVSYrhBKvhMdiVEY=;
	b=5E9B9k3rrvvrwquoJ8GlRSZY+J+V1tlV4YhaHrIFQ3Y4QyL1iJEjix5KO/21v7/7RMLy
	 wnI9Z6sDVVveyKu7IIR+rlw0RB9HcxP1uagyz4Avdd0j/w+aR++J/dc7A9zjcA5z9RCM+
	 AVElFC3rJ7hbn5BXJThBL7DCo2D6iSXaFIxx4idgi7LkcrFstffeIx/IKZ9FN+YRnYpE9
	 8HyUODh5Eu7df/m9I5ARjGxkR4qZopHGL9Sb9tRGDHiZn5yeH/kfiv+ow77ZX6+5OIc+h
	 5GiTlX6OJwODzHmG5b/JZpSnOfJif2l7HYSxpOeOUdKC/wlTM/LFY9nIIIubju/LOqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=pass header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail3 header.b=CHD7C+Ng;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=RZu9JR0v;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADB606A321
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 05:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42ADB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail3 header.b=CHD7C+Ng;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=RZu9JR0v
DKIM-Signature: a=rsa-sha256; b=CHD7C+NgYfWjkvxsbhEg74HPDXECg5Zl25RIo5DGZF2yfIVBoWXCt+eCVVJnN3jGz6cWtOVoDTh4PDjj99FE2ShH03GavOTuVqe+GuNkp6P0y9lp+z1dzZimp4nk/geZoiuWW5SGXpG4PM5w+suG7bfU49jUde3CdtRWjNpVXQpsqBUelR95o5zpnW9iZcPpcs9UusF0PhZzAB/MfoU8Y5wWbg7vE5g3pTrmx7q69QCxn808jLN5VDjzHjRK1ynLgiwn+7gnLUVYKjXABI4079tHPQEdYvVi77W0Y77PcP4q32M9C2QOcCWe7zTdEhGTeGauPxqRHbqB6zm9tZv/UQ==; s=purelymail3; d=arkamondal.net; v=1; bh=HaunAnj7cG+OVh5JIrUNiAJGT2BDPbG0sc6MuEKPxiY=; h=Received:From:To:Subject:Date:Message-ID;
DKIM-Signature: a=rsa-sha256; b=RZu9JR0vB89BMIDb71aCf/HP934dtPf3LAInk8GjMAS93MsOv5fmsp4mWsJIHHAPj3xd79LrvTDU68UTMYoWJHABQ9MQbw8UdSvpLKkV5gL9h0X9ZXxvoxNHbZyyL8aZm7WGXcA4AkvsxCMRDkVW4jB7ec/9jZ24N+l/cYBcB8yhBsfhQ0iI1eHTJBY4SpYXIDoCP6iynpWnd3jX7fCxuF8Jx1rTIDgpyWYh35IfTZYX6hOSBvAKmzHkARg//nS9icDWPRNZgICC+0Vl0riQEO+1mfoXhuNiwhTLOQxp4xOtqDWpbRT7A5gAGgceW8AEb3R0Vm9D2Qh4vCR9hX6esg==; s=purelymail3; d=purelymail.com; v=1; bh=HaunAnj7cG+OVh5JIrUNiAJGT2BDPbG0sc6MuEKPxiY=; h=Feedback-ID:Received:From:To:Subject:Date:Message-ID;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1850211063;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 09 Nov 2026 05:07:49 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Robert Eshleman <bobbyeshleman@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH v2 0/2] iio: light: Report the available lists via read_avail()
Date: Mon,  9 Nov 2026 14:07:36 +0900
Message-ID: <20261109050738.93424-1-arka@arkamondal.net>
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
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

These are patches 1 and 3 of the v1 series. Patches 2, 4, 5 and 6 are
applied and are not resent.

Changes since v1:

- isl29125: the available bit goes in info_mask_shared_by_all_available
  instead of info_mask_shared_by_type_available, which is the sharing
  level that names the file scale_available, so the attribute keeps the
  name it has and no ABI changes. The Fixes: tag is gone with it, and
  the patch is a cleanup rather than a fix.

- max44009: the list is IIO_VAL_INT_PLUS_MICRO instead of
  IIO_VAL_INT_PLUS_NANO. All eight values are a whole number of
  microseconds, so three zeros go and nothing is rounded.

I loaded both drivers against CONFIG_I2C_STUB under qemu and read the
attributes. isl29125 shows in_intensity_scale and scale_available, no
in_intensity_scale_available, and scale_available still reads
0.005722 0.152590. max44009 shows in_illuminance_integration_time_available
reading 0.800000 0.400000 0.200000 0.100000 0.050000 0.025000 0.012500 0.00=
6250,
and no unprefixed name.

Link: https://lore.kernel.org/r/20261102074700.63075-1-arka@arkamondal.net

Arka Mondal (2):
  iio: light: isl29125: Report the scale list via read_avail()
  iio: light: max44009: Report the integration time via read_avail()

 drivers/iio/light/isl29125.c | 29 +++++++++++++++-------
 drivers/iio/light/max44009.c | 48 ++++++++++++++++++++----------------
 2 files changed, 47 insertions(+), 30 deletions(-)


base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
--=20
2.56.0

