Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866735;
	b=y7VV8xtySusOT6n8NquSpTYJ9kksALE0a0KGMJl6nVslFUbd1bq+XY423nmho6DUV0R+
	 Nz/DkOhcUfGJhGo83nWeJ0nS0Xwk4bGb/jvlPaH6//4ZnJHDWRHZcgTEXMT0zEB7fAXFC
	 Uy1VY19qeVq50JJ5bDtEW2UkvBkPt2Sa/Pl1zamz/IrPQLEh352n0p8vxjZr8+NBKOUWg
	 YysoyNCN9qvQLKnOpsrwKEFgUYnx1Gnykua1uh5h+hgylSdoxJ48i8bO7wH7EGWcdf57A
	 Lxty9+dBNDXu8afAyO69EK0Wyg5Fww13PTL7LwELUMW1coLgqiWme6bSCUZiQYXQmJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866735;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qJOxHHAv6uqAG7Nr+OsCg5V/lL5wiFiDRAhynnKcyAg=;
	b=FJDHJ2l2mp3Xei83gdF7gxMbnn3iEE3t75QI826Q7izz1NCsKTNF8K5DzV89gzmFxO3N
	 l4cN91+cVM3jzlsyfK9UAerE5bgg+VzzNBdAxX5yCgPCe3WviNS0IooDOZVGa3c1Lxo9P
	 oDkHRy4WhMzN1U7yweoxbJnIo5QpCHHt/6z6RGFHC4t4M/D+guHEuKQBOA81axZu8IoUH
	 7mgdIlAWuijlUabCdNoIheFsBOw/0d8Y0k8JjsP+sweiCfQjYSPOgc1RbapY6555rvYtr
	 p802glUWTRMgpTCcAscM1g4G8RRi5tmKfkNisc6A8nHoo/DFvzCSIPqcFJX8ckoFFSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fy5PgE4r;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA204606D80B;
	Thu,  5 Nov 2026 08:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA204606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=fy5PgE4r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=fy5PgE4rq2cFCuQSS4cfs2YfNz6+74EayE5qCgYmORnsXmKZiv7UBllkBt6+FL24wd40/KCrHKDs1
	 qNHh8KyKvdP6yiV+0mSxdtnWBdZbRWSCqEQ/2fMdhUkjH2TNkUqZPbq7a+pXG9jT/zowtzYma9I1lj
	 N3ykOGrZYdH7Gin0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36aec3be9120-71508;
	Thu, 05 Nov 2026 16:18:50 +0800 (CST)
X-RM-TRANSID:2ee36aec3be9120-71508
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aec3be9422-41ca9;
	Thu, 05 Nov 2026 16:18:50 +0800 (CST)
X-RM-TRANSID:2ee56aec3be9422-41ca9
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: andriy.shevchenko@intel.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: Re: [PATCH v4 2/2] iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable path
Date: Thu,  5 Nov 2026 16:18:47 +0800
Message-ID: <20261105081847.953-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <ausd4u09AfIcviHI@ashevche-desk.local>
References: <ausd4u09AfIcviHI@ashevche-desk.local>
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

Hi Andy,

Thanks for the suggestion!

The runtime PM reference in mpu3050_drdy_trigger_enable() is not
scoped to the function: it is taken when the trigger is enabled and
only dropped by mpu3050_drdy_trigger_disable() via
pm_runtime_put_autosuspend() when the trigger is turned off again.
The buffer preenable/postdisable pair in this driver manages its
reference the same way for the buffer lifetime.

With a scoped guard the reference would be released as soon as
mpu3050_drdy_trigger_enable() returns, so the device could runtime
suspend while the data ready trigger is still armed, and the usage
counter would underflow when the disable path drops a reference
that the guard had already released.

So an acquire-here / release-elsewhere lifetime like this does not
seem to be expressible with the ACQUIRE() family. If you see a
formulation that fits, I'm happy to rework the patch onto it.

Best regards,
Xiangwu Lai


