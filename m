Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED9397E77
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961056; cv=none; b=mmFowAje+Oop+mWmoprVVQyqOOIh4BnNu7k68giNtGvd6ZfsVuqwVca7PXU1MaPXSXl2F0lDFewDIYScEYaYQL+jUx//68p+XAx4pUSlRmodnNe6SQI5NSjgaXnDjMX1d1A0qaXIb7czYH+fDx+P4HDU1JYg574D0DFHzFtMWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961056; c=relaxed/simple;
	bh=0FDCQ8Rn3JCnSeMVZApr8cnWZWJimAwKuukQ7Jmm4lA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qQ0Sp5+lOA0lB1AUkgznilnijZPDb+yZUJVTps/49alIdbKgRQYbmlSt9W+LSd15liAHjnleRicfTE3p0/PcePt0oj9QHz2k+fi6iLkNDbb+7uSSpzYGktv/yj0g6eSJr0ayiSxZJVD6swIal+VZZsRa+7PEbc+Mp8DQMJfd+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4W1Z4VD; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4W1Z4VD"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ffbd778410so29583137.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 15:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773961053; x=1774565853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPtWeCoXA8KidyRGoiMe9TqsU64p1S5/S/aeBC6UNH0=;
        b=F4W1Z4VD7IaIfnU3rtkH1VBDNbzBsTy5AqF21YYsoFx4Rbpx1iq04PfLka8GH2VfhZ
         54XU/WYnlPGp1tpoEPz98dIGmzjwRkPRe9qc5nL9R4a6RqBL2ezOlwEwxgBYo/VO5glo
         pOVN8VwrZ0X14R1XlWyoFEWGjp2R3bbPaMQx7Y74iFErdyEKKYoFcUqCYnMQ78Od0a3i
         6M3yewJUAONG9otcbeD8RO1A1omN9HFkCBHqCrj5aZqW8mE318Vrqy9P4fIy2wdrWayH
         cmpAjENMub4ew/8nHwivnIcvV7km0IvSu39jUMiGyzTGPXqNRQ1Iu1pEo2LgJmKDIFVx
         AcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773961053; x=1774565853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPtWeCoXA8KidyRGoiMe9TqsU64p1S5/S/aeBC6UNH0=;
        b=tC3GyKl5uyBkF2xfeTxna1DprrTwSjTB2Ud26ombWn7GYnMJsNwe+caua0rq/y1eBF
         8OvFx6vH5ZXhl7VDpfcJr4swrj7cmGDLrrQaw+DkgUyD00nh3JoVuMMYN0tyzu97GqLD
         8B6+gfsxttc+8tm4l6Q4gsZR2W8sbrPjdNT9ca3UgkaT7UPgoDX+wWXDP9IEeVkJdQAa
         01OFU9CCKH6aboP4gwQiiq0nElJMMPIDAX3OvoNpHVFMB2nf2Qg2yV2zVU9h4p727O6l
         0brkPRdHWBahEB+HjohUe48EXIDsnyJ36j5BWrMCnDb1TXIrHPlbxQpeeFA+FasgF07x
         hpRw==
X-Forwarded-Encrypted: i=1; AJvYcCUN0NKG167bxCLlXKOKu2xHakLS5XOZ/91iFN7CP5Pjy/Qno/wOnQXyruAGWVFkkH6OhfUNq0pWS1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1GBTWi0wrtyK/Eq0S9D8VIOL2zZbkgL9DpK348v7Z3jfl9jfs
	mLtGbn7Zxo3cGIq3TMg3CJdxfGFgYEJNBQLgxF2ZjYALcjEIr5wo2CxA
X-Gm-Gg: ATEYQzy/Feox0ktTrmoMiJd5+X62MLWx8qRr0i/F9KQbhWL1inSRqH5gwxSoyVWlXcK
	fvLLH3PwSVTghq0Y7BHrVijR7ox0DOb4ue1F2nCKQlXQk6oIW9sldYrWaJJzqCBuo7MvOwlHXga
	HjyTlbUC31+Ny2WPzREaX/ibKzEe7Fg3O1/Gk8TxwJLgrZuiIsopCzdojR8fyPcsITqIxNt3MN+
	XXbBafssb6/3LffrWHlh4Ew+FIDKWOuSyfQZO8QdLSzgOJQa9u1HGS1RSS5d4aOA2WaoVBUnKG1
	060rNxAyebvxgmJSvn29MUij42YCMQ32VTB3W9/+ZZL7MVEaxGSjZuYbVsg3H2CTF5e5iyJ2ya3
	MPY8Hehj5Ri5tuc+PXLYCRsaMnI4hj4dfOlB+GNep7S1Wu3lzqKVbXxBNA6HjkBY9/quMNW/tFB
	te3bU3Wg8tp5NUWP9yhux8XnVLXGc78EKpSg==
X-Received: by 2002:a05:6102:38cd:b0:5ff:2569:cfe7 with SMTP id ada2fe7eead31-602aeb03336mr648279137.10.1773961053299;
        Thu, 19 Mar 2026 15:57:33 -0700 (PDT)
Received: from localhost.localdomain ([149.102.251.107])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136bd79c0sm204828241.6.2026.03.19.15.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:57:32 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: iio: replace sprintf() with sysfs_emit()
Date: Thu, 19 Mar 2026 22:57:16 +0000
Message-Id: <20260319225719.73587-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the remaining sprintf() calls with sysfs_emit() in sysfs
show functions across three staging IIO drivers: ad7816, ad5933, and
ad9834.

sysfs_emit() is the preferred API for sysfs callbacks as it is aware
of the PAGE_SIZE buffer limit. These are direct replacements with no
functional change. Build tested with gcc 13.3.

Gabriel Rondon (3):
  staging: iio: ad7816: use sysfs_emit() in show functions
  staging: iio: ad5933: use sysfs_emit() in show functions
  staging: iio: ad9834: use sysfs_emit() in show functions

 drivers/staging/iio/adc/ad7816.c              | 16 ++++++-------
 drivers/staging/iio/frequency/ad9834.c        |  4 ++--
 .../staging/iio/impedance-analyzer/ad5933.c   | 24 +++++++++----------
 3 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.33.0

