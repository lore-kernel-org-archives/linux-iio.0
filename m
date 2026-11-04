Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810724;
	b=EsWrVCFlO4CXvHZ7CsA7TTJpIe8Ar2ex4zbbq0mg3JrzQ6tK6TPZlMsOGaCXzGMut7SE
	 09vJibmNM0FzkN5Y0J661EI7vtjr8q5V22t1WVPSu+WsLo5KCsgMEs6FMgs4fyXxQ/C2U
	 JwMYDS719oj2bP1K4QUF8yCCIdGkvsbcI6uBXprqN7yhbxbts8w+I66uYalUaHy6nVD6F
	 ORVDCzDY+Zc+DcdfDOQjO5o76jJwS0kpG+AIDzXp7gwUufdoY8ro/RM/QuKPF2QCW93yw
	 e5POT43WiC9xonn+Y6BNFbYJEIMWsPOtjz1xRi84BuxzAIZ9JVWbFpFsZYF/9icSMrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xcudQ4a1QKypHuZuwVny/qv0KumrmKrAsLkHCKA1dD8=;
	b=4j5Pn3a8Qw/IO3vJh/jTQWDhZTv72/yMhA/igMpfGJ1zDg3ybkIRzxKc3b2nIBGF/Hab
	 suuZJRY7tffR479CpObjml8trRVNkc81B38G788Mk6T/Z/A+EYTp9gX0dpjsup0D4fKJe
	 vXVNy0QnAv2qpdX83EEYMrG6mOMUgKV1tntxS1nW5QqEcBqgbQtYvJDcqsiEyktQObD4f
	 mL/NrcgtXv35kzw06LBlmmlRCxhKCQrNUoW9Y6b53nZ2uJeOkb0l5a+6473xbAF5tUXID
	 VwDdlWLCbUDkzgiQyc1C1ae9x0A6L9C1DOiG/lc3tN7n6eQf05kObHHz6XGHMMAM71w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="aCJZ4/Xo";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2722606A32F
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 16:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2722606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCJZ4/Xo
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3282db206d3so1739993eec.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 08:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810723; x=1794415523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xcudQ4a1QKypHuZuwVny/qv0KumrmKrAsLkHCKA1dD8=;
        b=aCJZ4/Xo9jKnaTImkPsBsYrn3ZiAHaVH5EYy0bf6wENa9Kq1tc6D6GlpvX5t0fkziK
         wiAUHhfbnFo/FFaTP7tTCp1b8oDIUKJNqcc31oM/cgw5UTvGs6A7zVMmehHfmeh/jSh+
         aDMBdXQ2XaaFhxuyQ0m4HZvj3Ao9VTgB4PbCAGxyOrHJNWc5imT1XVJXThXCSeckHrd8
         FzzYh+R/uLqI+X/n4CgmuKQVIF6q2obULzITNmNETkMsHpPdDbK4/aeIAPeBTPshpCmV
         JHCKzrf2gIhUIPftDnZYbaq7Q7rPcyllVwxNKOtUTIfy/Q3gqhTysqJh3PWEP0QYSyc+
         8r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810723; x=1794415523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcudQ4a1QKypHuZuwVny/qv0KumrmKrAsLkHCKA1dD8=;
        b=cFlJUCF2sO2NM6RSpndxI8emrSpQth1mEB6dx19KaTFp96GNNne9iG12XcttRwSgdp
         sW4pYAcB1o2frm9X40kBz9LdXoaEv6KBfllMZgJiCFxGND8xD2bmTWGIFZawfujCdcrd
         tN4NnpyFio2oHYFLQO4YET7rRTYinO4m7oNetFUp8p39mbBVYR/PRpTdB2Jv+gVtC04r
         TCZ/gMgnkfIsZezQnw+l0QB5KekVgjFYb4rTqtgHgFdJFT7Arlzfa4d0qkVtqUEC8Ept
         oiofktISPNTjuirugLh1rjfQbkxFG6nuSRsnQgaady3Sw106gc2wpB9dop9j+X2rFmMM
         3B0w==
X-Forwarded-Encrypted: i=1; AKwUvBzskva5DDMahqHSacPHa6222J/yMiXcuy7W+GxB50MOVaaehZdYhQXOz29id2BWJe1vtJn5Zln1jCU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pCu3rr9bWOoR8R3M6VrVbDinzu4a7QNdigC1hDaV+tKataY2+
	1NYJO3PzdFLjZC8Jenx+sRG7C+ietnbpH+FTnevzE1I8RiNu2VqbWfwG
X-Gm-Gg: AYBFou0rFnuFtZ+ypRpdS8RFJ0tdadJ65gCVKf9IwJHqRRb0RJn9cXMOF6Xw5zhoiji
	Hoi/zt39rZF5LXrpyfxYj//eZpH511wM9p29qJBC4+aei6vAE0iTS1V1nSiTM8rvm6GrxE7pTIa
	DUYyRNdr+nvrOPvFOanybIJskQsgMRLa+AnEXBwnv/hO6+hIFLw6T9khNEnu/+thk6SNuYiNQMH
	OBBpU2JQFkR39rHAMixfxdKsOJPPEs4gtw9z4PPJq5vDlnILjWOdJYGnpaWw6JOLwlToyLQXelV
	08juVN2RiqTXxWwBAkWPTH7y5tg7b3kAQCPN7xufETZ37DFC6dOjYOAjz29sNcHRW+e8JywjfRT
	R99ZQK69KvmlKY5c4ULdbR6OqtHrJcoYSSh35Imlfo7MzktX6HYjAaY25Cp+oZMOzB6WFBNO4Jt
	Eg9rwOl8kVIiqKsAN5aNuijQGRh6I7QXnF1vGUKhWoalupJvS+VxmztqDExqOsS2luViOwGrnYE
	93kKvwGm4ZA5YBBmmgIrHHpSyIjSXnpcv5bCKShUj/ZranW2oQESAmgwjlresLPQWCjz+xEr7fX
	tjx7UT6ECmuB8mhYg2lY49WFVEZ4+6qOCubB/gQSJ3ku7gqPXBW2lOE7kSqs8jKGf+EZNNlBJdN
	yhoTtJj4mtX3+kmh5yAWoR87UJOsXWiAbZOldrzE1LxJLVswCv+zXDxKeyjWaBG7XGqxCNo8f3c
	zgvBylR7SbRKCCQDPc9InJFiXHT154UlndUoGyXoynp0O9sflTk/qMGmmQIP/FbKE=
X-Received: by 2002:a05:7300:a8f:b0:368:4c93:544e with SMTP id 5a478bee46e88-36a422084d2mr25419815eec.1.1793810722385;
        Wed, 04 Nov 2026 08:45:22 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d36a1sm10368825eec.12.2026.11.04.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:45:21 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Salih Erim <salih.erim@amd.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Wed,  4 Nov 2026 22:14:59 +0530
Message-ID: <20261104164510.105359-1-kapoorarnav43@gmail.com>
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

The driver sizes its channel array for 10 fixed and 21 external PL
channels, but accepts external channel nodes numbered 20 to 50, and it
never checks the remaining room while filling the array. Channels 20 to
29 are the fixed ones, so listing them adds duplicates and overflows
the array.

Patch 1 limits the external channels in the binding to 30-50, as Sai
pointed out. Patch 2 does the same in the driver and adds the bounds
checks from v2.

Changes in v3:
- New patch 1: limit the binding to channels 30-50 (Sai)
- Patch 2: only accept channels 30-50, so a channel node can no longer
  duplicate a fixed channel (Sai), and add a static_assert() that
  ams_pl_channels[] holds the fixed plus the external channels
- Patch 2: rework the commit message around the duplicate channels
- Rebase on fixes-togreg (now on 7.4-rc1)

v2: https://lore.kernel.org/all/20261023185652.195025-1-kapoorarnav43@gmail.com/
v1: https://lore.kernel.org/all/20261021225356.625288-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have ZynqMP hardware. dt_binding_check
passes, and rejects a channel@25 node in the example.

Arnav Kapoor (2):
  dt-bindings: iio: adc: xlnx,zynqmp-ams: limit external channels to
    30-50
  iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels

 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |  7 ++-
 drivers/iio/adc/xilinx-ams.c                  | 57 +++++++++++++++----
 2 files changed, 50 insertions(+), 14 deletions(-)


base-commit: c293f0db308fe76a0a9b0f6674cd2dea149b03aa
-- 
2.53.0

