Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B7F370AD9
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021251; cv=none; b=FI2KJ2YXtkXFCPjoTIxcS+W14JeZmpiuoBGy0Dq2X6zHRcvCIyo2t05bx7483mAepzw8O8UF0RI6lCMGFoMToJVfw9bNx4b/kuWYx+tgduOOBynfi7fiBnHZVOmNVL/vXl8NSIgk+e4evzFP9f/BUSOQOKMpWRHSdNFtAgEYmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021251; c=relaxed/simple;
	bh=0oG4tFe6RxchaDBi636FO+9cLdt8UjZ6HP7n572C5wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrdMXNQwtFPN1PyxIKubDGOYSOKrWME/InEtd/BZEkFjykUpkic7jWQuYlqsfFfQe95yYbeSHm12eC0u8iq67AxyExvq/pdoYpmiuW5VJRHP4Wy+10gPsGJnS3oqPAIOiUeGHDXcumFI4pXm7t+iPOmM+DtOrwaWqWo7k3reXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klXmveWR; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klXmveWR"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69d8f70cb0cso4041644eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781021249; x=1781626049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=emqDFhzdC/Zsgjy69nTK+24HGtCnjO31EuqUD/X+UTo=;
        b=klXmveWRXjlObZbOQTRNUCU7aeRfxukRlG1jnr04qGfVH5xpe1rAJi42vLGsYZ9e95
         AHQVhN9tUO4VaXqQR7W5MDlR01LBW2uG8pds78ONeL0JbBNNborqdMCJrEQZzGulHa34
         GVnV4Kp4CD+nfFfLio5TZDznCBDfczwMlUeQWND7BP9/irUXQGXaWV9DfW6Fdy3Qb/fb
         aKymtatrQCWhQrEk6CHT1eQHVaEfB2yiZULSF9hQ8CgSX10SlMlrWL/vT58Bb3WhGALr
         pf/j4SditECg3jaxQytGCN/89pIigmIgj3TCFym/RV7TdoU2/8YcdQ6uVRZX13/x/W09
         EfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021249; x=1781626049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emqDFhzdC/Zsgjy69nTK+24HGtCnjO31EuqUD/X+UTo=;
        b=NfmslPcd2uKT/MTIsWr1tiKEpwtJhaAwl83LclEehzxHeYHO0GJLZG3YOec0Ff8KuU
         gknFg4e2SoF43TmruVe+71om9/lOGHz4tbn5oGGRjA4SeH6+seTEZFEphTtbPLdqoc0Y
         biPEkMZQWJjMjOWzaHurdAcwiFccfZJrJ/Pi9+i5gBlA4I6EslKsyTP+8JhxN6e7z34x
         y/m5gefd22BSVz3lpldFH42igzD2sPw+pW51IaeCA1dHufWux5qUPSxqjteW+l1o/A6y
         cqnlxP91zbff7GdTxIAe3jiLYdIx+6Gl+vb6Dh3VgNSIt+7K3PjWhgqoRLpKKMVZqljo
         0TqA==
X-Gm-Message-State: AOJu0YwqOCn+nt4cCvgrrFh4YTs5EZAKwIKiIpABYqGzp/Lcn+nmYI9O
	ilH5/UsFvSNrXE4AUo1/HrJkviLCElBiGTzF1MMd7vpMFUZ5E4iTRW0T
X-Gm-Gg: Acq92OFF1dXAeVU9Li9d0pXYtGMNJMZzp0szQVLIs8UJM5BHaBnDXxJp29KWPDEE4hh
	ehM5Yu2M3j5nBOWPFqxi0QcLcWwSFM6Ae0sn8jOXvstiHcYgbKRWFCKwLs0VQFtk7UNghvh/MNy
	xgG6Ak5g0YrEg5U3tfxD322cSE9vslSi8RmzngR4JpyqGFiuN5/oC+KkaK0dNqCnl3LZuK/iLrm
	ctbFc8lhbEmUx1YErH/Qc2EsOkRcqi2UUnkxd3HJNqKuQaG7Zu6uW1sSHED++poptFWh+JhVZhT
	o4/gIc8H5KnSxfvwWT2BW1ZBQl8R5x3TgQczzBKxoMdaHfo9yLt8s4YnmqvjibcWuPWw7tbxjIT
	bYhb6H9nNYVdOZsogTiAft64qFoyg3UF1osfPFwsub8jEo38RROPFm/ktFP/H862LrUix60RTv3
	2PUP+CYuB/7xZs0Y6xSMgFORQpcsxabreM6S++Cneh/k2v4ksZWc9YiY0e3uzzwZzIUiWQ
X-Received: by 2002:a05:6820:188f:b0:69d:9288:66c8 with SMTP id 006d021491bc7-69e68b41cc5mr12659270eaf.13.1781021249548;
        Tue, 09 Jun 2026 09:07:29 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm11393859eaf.9.2026.06.09.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:07:28 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Replace Tomasz Duszynski as maintainer for PMS7003
Date: Tue,  9 Jun 2026 11:03:24 -0500
Message-ID: <20260609160326.45123-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all.

This patch series covers replacing Tomasz's entries in both the
PMS7003 dt-bindings and his entry in MAINTAINERS. All of his entries
across IIO appear to be dead, which is why this is being sent.
Jonathan Cameron's approved of this [1] so his entries in iio are being
replaced and an RFC regarding this topic with Tomasz Cced has been
sitting on lore.kernel.org for about a month now.

Maxwell Doose (2):
  dt-bindings: iio: plantower,pms7003: Add myself as maintainer
  MAINTAINERS: Add myself as maintainer for PMS7003

 .../devicetree/bindings/iio/chemical/plantower,pms7003.yaml     | 2 +-
 MAINTAINERS                                                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

[1] https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-huawei/
-- 
2.54.0

