Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814818;
	b=QanmpEVqvCB11BSEJ4OihE6lwnulXUb39Twx2VazDxz/1vc+GPIx9VyUk5ieff5a6Bwf
	 J2xkrMtZX6s7nisPCV5KtAeUoPda8sla7lUnnMt8m80XAqZjHtARW33RbZaebNFZ30G0o
	 0rYG3sajtAb6gNPm6QsB+ATiz1YYPofO9pkMdHigtDoimRq9HpEKInd1vKklWhNQOWmDc
	 TYnnebbV1pdzIsZNdquG/wN2ovJIhYM6cY0x0OK0Iv5oXWPrNU9QaM0MCVvJXTjEd6HW9
	 3yBu/0nXngb5tjarjrZUM25pF+sOgRFbs9bJ2py1KuaxHdQb6GoGqDQ9zhsLv5dZRXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NqqPkO6TP9CP+I+rGLVpJtch/uB+AU8T9QDkOfxCb7M=;
	b=AlFdhAA9qidDr+Tx/m3dfFL4cpckMI1CpPS5T7uRLDJrApzjYs1Bn0OwJPg+ymjvAR5S
	 HYAUQoQw5JVktNEl4CTw7xw6eR3AxOSeDQ/Y2jb3hepbEDHrSGcp+bk1uDX5a1DosgdXj
	 qF6Xjpk68knqVNVy2/iBHw3aeeyXNosL1eJpkX0CTiUud6kBs+KYQGv66EwNmbqInpHLp
	 Jals737fhKIbEhdjyfmIg289293FASV1R5r5HABboguChN/uCI8I5LkpDmhQlCjb5uVj1
	 NZPTee3AZ6Q0mj6x5Nc9mOlO+lZyx+Z1ghzP0I9+5rMf/LpVqNKDtjES2h3VIlkPmJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G06NtBSj;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCE606A8A3
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 07:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50FCE606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G06NtBSj
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so18354675e9.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 23:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794814817; x=1795419617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqqPkO6TP9CP+I+rGLVpJtch/uB+AU8T9QDkOfxCb7M=;
        b=G06NtBSjoTjhJShTRkcPAR6AQMurGbI3UCOUAedyls4HuNZ/+Vjwf+roHnovmdZPJ4
         uRMPnMdqk3fsmDfXq4kxeJVjqrqwkNOQsn1i5fWmH0862jJ5MVtfN9/ZFNc3Vq9mcmKF
         8w7lpDh/4W8YDreTFWVhK5AXxtWIX/3tYmOpOpqTEw+TmL0dy39kg4lxKU5rhKrZdzsx
         R7Fl6YQ5nKyJ6TFg+L32zCK+AhFbWvD0LGEFuV8Prp5X4VI+dgyI54jLUnu4bIPbSgpF
         YFU4LNR3H+T5fGCAJX06AAhGTZggLbgkeWWK5YYf9T98C3wDff22tGH0Bg2pSJOoHNPw
         9WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794814817; x=1795419617;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NqqPkO6TP9CP+I+rGLVpJtch/uB+AU8T9QDkOfxCb7M=;
        b=BtJJOPsONjjvlrxgZ/q7z40plVU1nCHz6xUTEy6IwK7F7AB0FMaVQVygOhxGdxLSpL
         U14Pc2jONp0iL4d4BBEYW6lBjwVEKl+TncKyx48pl8VI8diYIpi0QPGePuH3v4OZYMg4
         j3okTx30YlJ1RUdzM0IK/p9cOf5bkX4NFSGXR0KG4609e16KfpUbLrUeYHe80WZH9UE0
         8Z9eEvruxcCbcf98yLmQ/k4rnZwVp5HbcvLCinfycBTBXCg4o2sOf34op/pg8Z6G85hx
         53Xze/yVyOAfSjsxUl/XmnZDML4YvWV4Nr11lqWp2sE2l9c1glewa8Fk185WVrtzb+u8
         Z9AQ==
X-Forwarded-Encrypted: i=1; AL+hErEx8YbgxCVAoxXoffy14IlgvzkS0XzXx2K5wBCM7P6/7q2BxC4ZJpWklm38zfqRyT+uQAH1lxfa4sM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UbECUYJepZGlPMnWtIRUrAvvbByzJkuDBIG3tCL3axwEWeMKM
	i5OtKWIWcnmyiLSLDcBFSp8CFPtUSk1ibbE8MyfpRzyYpDvOsbdXPJRk
X-Gm-Gg: AYBFou3seC64hLj/3sdBMj117V2Mmy1aBRY9ONFQSW1GOX8R4lRlSVYh6efYBBdZU8S
	a8eTM8amHqjSzOrEQW18ETKFgTkAdvSPpwT8qbKpZwgw9goTXEpzD2jtWAVwEVKxm2cu5pPHYSw
	1qeaSwwOCOXhVYDeETLfKWst32kAZk011PoxiyNH8UKpArRFMnpKlbbRUsoCglBYnJvi4AGqTeV
	aJEdIF5LPnmfYH/sTneyBaxMs9VsCv1YC2cWpqgvyEJMRf5OloPuNEHtGmV1cAVnyl8UXbb2vSw
	d04Tb4ElYy82a1KqrHGqWfsSOopTOSU5DbEBGxz6Opd+H8f+w7U+fgliwHeJEAAtlUq+pNye8B4
	4DuZS4mlPt5M9hchdnu7t+XgMCoxzru9OqxlrVag9+3RTVJxChn/TK+OAsawZdH2cO9Vf5trvEp
	20QaTBimtV8YT1HlHtsiE1ECh1zlW6f1b9zwtLmLntBTIEANz/lcGB+cSdJlBphHY8GtbV5bOfT
	DumsyIdKRdt0j0bQmYAxL/PpqSetF3pqmBV84DeOC1PCBHEqpDZoQwrYJU5E4xhzvqhcNc5JdHj
	8pOg5oZXYpsb
X-Received: by 2002:a05:600c:83ca:b0:4bb:53e4:a7cc with SMTP id 5b1f17b1804b1-4bb55a74c2emr200060065e9.30.1794814816575;
        Sun, 15 Nov 2026 23:40:16 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm259712705e9.2.2026.11.15.23.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:40:16 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v1 0/2] iio: proximity: add Imagis ISG5320A (Samsung Galaxy XCover5)
Date: Mon, 16 Nov 2026 10:40:11 +0300
Message-ID: <20261116074013.355363-1-tadilhusrev@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds an IIO driver and its binding for the Imagis ISG5320A
capacitive SAR/grip proximity sensor, as fitted on the Samsung Galaxy
XCover5 (Exynos850).

  1  dt-bindings: add imagis,isg5320a
  2  the IIO proximity driver

The driver exposes one IIO_PROXIMITY channel (the B-channel signal minus
its baseline) and a rising/falling threshold event. Tested on an XCover5:
it probes, registers the IIO device and reads a stable baseline value.

Based on v7.4-rc1.

Tool usage
----------
Derived from the Samsung vendor driver during XCover5 mainline bring-up
with an AI coding assistant (Claude Code, Anthropic), which drafted the
mainline IIO driver and the binding. I reviewed every line and tested
probe and read-back on hardware. Review comments are welcome and I will
answer them myself.

Adil Hüsrev Tepe (2):
  dt-bindings: iio: proximity: add Imagis ISG5320A
  iio: proximity: add Imagis ISG5320A SAR sensor driver

 .../iio/proximity/imagis,isg5320a.yaml        |  56 ++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 drivers/iio/proximity/isg5320a.c              | 857 ++++++++++++++++++
 4 files changed, 925 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml
 create mode 100644 drivers/iio/proximity/isg5320a.c

-- 
2.53.0

