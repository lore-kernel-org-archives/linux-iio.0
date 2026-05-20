Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EC733345A
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277322; cv=none; b=WFYVEmZvlyIPBBgWX44TF6Exmtiro6s0hZA2QSBfYkyT5nTrL3J9QpnRMLg6yGRrDL9jeQCN6XlKOzBXKfJ8mUGPWKpB2fyloa9aC2a/BejqO6Fx5vEmbuFWd9MvpQF/CN+xyWUtww4LEn9gU+b2dX2VlGwPkw2r0NNo46lqOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277322; c=relaxed/simple;
	bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpI7vXieFQRUZEGhjisyT/09/qeRTeCce/dt4Ql+eQlG2gbeG10xSGnHECsjjebMGfUINsxD3X49gQIO6niHoWt4h0ogkHYav22c3TygybGWwb+XBx28sttHh9q7nO7UwBmnz4UGK/mBfl4+E4algBQRPP1kNvP8ON2lt69y+Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiqW7xEj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiqW7xEj"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3937a1f9f7aso5790631fa.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779277319; x=1779882119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=YiqW7xEj50cSSpYM6VIXYULIrNoSdZQfPwfX5ODEB+C/Oy9gPd7FbJhTOcA1EEC0V1
         /dJW42TRenhA0X/r9I0JgGa/qbdKtTMbfVRgF+iuk/h1txO5wZzwhP2LrzGNI65h0MIr
         2E+soIU+/sQJK2it196VxY0QlG874HiHwP+0lGNyTa5zb8APuB8GidBL03m7vR3+UUOF
         fflHbVx1wotWa/5bFjIT+y1PhwFNPB2ZlMW8VnA0R0/FWWqMwUUx+iqGlFbVDrm9XEwg
         t5riX50J7yxNu3HgtdNXYEC5+9MdBOwUz9UULJ69fh6HI09B+R7hXmveBvqvW0jpWpgK
         8DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779277319; x=1779882119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=DmyuiXAzMAkKy0k8PME8PiQFEYLt2jrQ2cX9muFeTFSaPXgethVYwZFQ0xQJB7/NUb
         sHRRz2OWrzWSxt20bHA5zsl0X1FzZjCrsgEdwhJfbDQqltOFfZbzwq2kMSBZ6hlKF18A
         FOSLAdShrljo7IUV8+SmHOLxgM0lh3yocuwCnICvuJj3HhHcpIid/1KV70UATtpQ8CsQ
         wB88CQEC74fQwP5r+JfChKS9xttC/L75uxEaQHrJLNOlL/H/K+TZt4E5HaBfR/xuYOqP
         qIxMsUFrw7AStYxWpuc3us5EOgpSKBBa/1PUHrYupkwqYm+mu2O82ALkKa8vlMa2Ut4z
         4QOA==
X-Forwarded-Encrypted: i=1; AFNElJ8LZIdPDRsmDLbpJ2x++bV0JeNHayz3j8u+9YzwGjKoj5TssNvtNbTkCMFgHc/wjzK2qn+RLhI6PO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTzWqUbMHHkzIgu+9dcG5Fld4lnr4QAmXMOJCP6pTaLmR0wMs
	7AHiTsjfQYOFlJq82cUlplLLdaJz2YlRcIwFBgASIpxRsSbFnqvh7ihz
X-Gm-Gg: Acq92OHuBun52Ra+xlbpcQtAroKR/PGuIBgAvDc/B6BfwDnJXMBrX4AZ2wyaDJAiSMl
	tdrANZW9Y34YfYzvgtILgiyn26G4mNumuJ4DXDBFSYvez2FQVaqk2YRnkFBFQYG8Xjr9/NzBo1Q
	3Ilz0BqHZ7t6KNQom/depRCsUBd/bc+BEJjxkrhT9vUFHPtp7YEzLNfq4ZK5FkbdLYLo6eGMkRb
	Tz5nm5X+6QRAZtCrp/0VRnc9v2lGv/aBQtHJ95NzNStbsEZDJj1RE6o3krCtRJb0BnOXgc3RnHb
	Cvc1lPG/34l7N50lUapzK5N3jjFzczn/2sO+Uozm7/WxkgI9Tkl4Rw3UBXsYc/hTVC2v6ViYDvP
	kCCq+Ul81SWbzXuhQS1IpWOYwQhKFa+f4bEEWMTHFgwuQmAhpPq4ZDAO2GLobjL1C244OPX0+Le
	tizF/mj5w0g7ZfBuqYh6AFE92Tq2fOmJTyCRTkCpTfywM/e+s=
X-Received: by 2002:a05:6512:1254:b0:5a8:7c42:bebe with SMTP id 2adb3069b0e04-5aa0e97f14emr3667233e87.4.1779277319327;
        Wed, 20 May 2026 04:41:59 -0700 (PDT)
Received: from localhost.localdomain ([213.230.116.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc39fsm4882533e87.49.2026.05.20.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:41:58 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: wbg@kernel.org,
	Jonathan.Cameron@huawei.com,
	raymond.tan@intel.com,
	balbi@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH 1/1] counter: intel-qep: Use devm_mutex_init()
Date: Wed, 20 May 2026 16:41:44 +0500
Message-Id: <20260520114144.14830-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
References: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
