Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4661E5201
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141207; cv=none; b=Bs69632oPs3aEWXHnzDHqJT9jo32KCYN+v47K9D/nMMZyaNCnrNgeEWEbgAJ1L1UfNneQwKaWwWPR/LpKywMsnVTnEANrs25fnoP19XtYyZD+nhT7tk4PCVrqzdP3cWZ/3sEL102gBDb30AZ9rkPRpohO8hUo2fyGRN0vAuQN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141207; c=relaxed/simple;
	bh=K9N7M1ZjN3z1WJxYykFBbNi+6CneAf8c60wxc0WHulg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5JqAQF+n+Ho9vKpRlhgJgDSkYrTkkoMkvFIZ4pfZpLcLgr9KsdK1bcIZMr+Debs8i59yTx5EMljiLwYdcZFIDquj4AQfz+u3B8dcuuzyPNBJIx4pjWy+obwfw1Hgdim/qcSYhaSpcjD19FMM+1S9wbkUGfnVi8ruQyvvbWWAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZREa0K3a; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZREa0K3a"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-841513664bbso4866538b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780141206; x=1780746006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=luqBjoqoF3Z7JDzd6A8AeZTGf17c0e9ADpiWAI4vL/k=;
        b=ZREa0K3aYS7C46qJRsbV1zq5hJw2MwERhtF4bRIumP6NUx3iUYS5LjZFxf7U1it1hW
         bLX5cQDmVAxLGV7opityR2IASHlLLNrKXrAs/+nxUL+fkTWbEehW9MQoDVGlyK93HE6B
         S7pLwsUBt8nScEmo0CYzVhQvbUxFC5PAutnH++JEcsY8GOebAXdNmaSV1aGxgJehBU1W
         nmRB5vWMfCR+LuoBxzFFWRueSNXdbgL+t3nnHP0ucuid/iVrBEFnlh2/fuoZx4s6WxS4
         zBv8ohO+VBUonJGuE4V6C5VTkQ8aiZmcMEpwEcmiTgBOe8l+T0WDoPQJOhbUNCbp7n3B
         2ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780141206; x=1780746006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luqBjoqoF3Z7JDzd6A8AeZTGf17c0e9ADpiWAI4vL/k=;
        b=ZrfN86ZbgSgYle99xJmNlFgnuHu7xl2Pas5za9oZMVnp1l+4r5D2uH8nMu6y3SfWbZ
         2O3mfPpOwt10cV/jZU5zT0lYwxTuOK3hdTlhAJG+kOYlODf2SSBuQKXcP3+qPRn6CNLy
         rxr4+vM2C7Ja2SFn62QWsJzi+bLvFXJJcAx9L1KsT7WP+/z2sYJg7I3Cj5xseQur7AIb
         A3M3eXsNpAAfClS0LLNIscbQnXRsthpZWOa5VSqOUgWw3WgM5vzC707O1sWKeEkz4eje
         PAD4ht0nGhhUmUiK2dAvUHvrzTcxqrZQ9qVGNYyUhCI8+HXJkLSe+R1AGfpyWx9y6AUZ
         IgYA==
X-Forwarded-Encrypted: i=1; AFNElJ9k/WXkPRqgLzRPugHMZdECdsfntrP+DuxIJzJ+fwkGapClsNn/YdD6vp63vmqTuOkHGEhnWtTauv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xqI3+isyiFbynephnmS/FaeavVAPNBZzZ/zY50KFjj40CyPI
	OqsilYJc1Ud5zUKyw6i/In2Xrj0HATb/3b1JejEWHYkhhweg5aKP7GdB
X-Gm-Gg: Acq92OGpWdF0mk+37hO+Nb/M7XO6zKS9UempQM7Kzq9UTe4q9RWV/pJ3eMkijx2m8Mt
	p0sL8CdArDyEyc8HipctM8zGsjjiETo1q0nBP8L0irGBx2+tAX+Ps05Obg6jiO/7CVXJQ+lnVny
	gaDCJo0zYq+0AIVO8CRUXFXwo0eVOREeMGcKdTjuj8+5/Wgqxt3bU83bD2ud0qeXBePlO0Pq/e5
	kp3U47lls7zNwl3hSYGhfesB9XEOzsUj1C+19EpElizVbwSJQE97o2Rqusq+u1dH2dkEWZyctDZ
	bpLOvu8LU2rVyvUkJC4EbmNf4ThSxW/Zsr4cVzI4vPE+yr9hsJHcOehGh8ZOTISGuA3CX7Tcwag
	gt9QIXY7ML0FMuy6k40EMckN50YjkdPX2TC8tT8l6Bk8lFJPcss6LxPwH6ke4rq1ZNwyXQdWrkf
	gksjTqm3L8UsON8QDaD5CblGa3CHkveb44+bTRFG0mh88iRREgTbfq7ftYAA==
X-Received: by 2002:a05:6a00:909a:b0:82f:1f43:7190 with SMTP id d2e1a72fcca58-84210934847mr5368824b3a.3.1780141205793;
        Sat, 30 May 2026 04:40:05 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b6797esm5467518b3a.26.2026.05.30.04.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 04:40:05 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	apokusinski01@gmail.com,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 0/4] iio: pressure: mpl3115: add hardware FIFO support
Date: Sat, 30 May 2026 20:39:34 +0900
Message-ID: <20260530113938.171540-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MPL3115A2 pressure/temperature sensor provides a 32-sample
hardware FIFO with watermark interrupt support. This series adds
FIFO support, enabling buffered data acquisition with reduced
interrupt and CPU overheads.

1/4 - Convert to devm-managed resource allocation
2/4 - Clean up interrupt handling and locking
3/4 - Generalize interrupt pin routing
4/4 - Add hardware FIFO support

Tested on Raspberry Pi 4 Model B with an MPL3115A2 breakout board
(I2C1, INT1 on GPIO17, falling edge)
- FIFO circular mode operation
- Watermark interrupt generation
- Buffered pressure/temperature data acquisition
- Buffer enable/disable cycling
- Oneshot reads after FIFO operation

This work builds on the DRDY interrupt, triggered buffer,
sampling frequency, and threshold event support previously
added by Antoni Pokusinski.

SeungJu Cheon (4):
  iio: pressure: mpl3115: convert probe to fully devm managed
  iio: pressure: mpl3115: clean up interrupt handling and locking
  iio: pressure: mpl3115: generalize interrupt pin routing
  iio: pressure: mpl3115: add hardware FIFO support

 drivers/iio/pressure/mpl3115.c | 421 ++++++++++++++++++++++++++-------
 1 file changed, 332 insertions(+), 89 deletions(-)

-- 
2.52.0

