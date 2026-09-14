Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F7A33F8C1;
	Mon, 14 Sep 2026 03:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355795; cv=none; b=h6Bv9BJC8tHMULY6HLDXUt5+6wUow9e19NkzKyedWuq5etXG89rU3ucRBkEga/vflkHwfmo0x5GmcrTt47jWxSgQXvYMy4bwcxE9cXB5vGeP8Vu0W5qKufyXS+4XRCkQpP6GCneq8TFd0sVuqo08b8Eh9eO2AhmJ64pY/dH9O0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355795; c=relaxed/simple;
	bh=900gZFneta8CbxXyjq3iUNKtG67LQUzfzxwe+5zTEyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU+4TjKOlgXPOiWXngFcVt7xaY0Kj+HgAvnTg5ClS1qLxS+OrmZprnxCgCs4jYWnB4/LdG3CSDNT5AeeNJRVKX/6zZ+IwGMzTZDkqJiTl5EL4VmA5T6Hfo1cskTvY8kze84LPnHll+yclTCjIVd1pxf68UlOzXn9WXdEMOdqiHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ARMNKRLx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ARMNKRLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lL
	lOSon+WScjfHrVYYr5SI9YAeNS33xMzWvQo2vGT2U=; b=ARMNKRLxXn/Ac8B9w3
	eAnrydCVNY8LHXO3UWpwlwmEQbAVzo5Y7cXtD3bCp0N8SDD5JlFhYOCwBr0X7SFP
	+ljWfvskiDXO4wvj/JW72VfUVpjBhG7HV+b5tReufs+Mkw7KCYjWUhZHU976SAxd
	NNAbRYyjw00YKnBKEy8hh2AWc=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3naXzZqdqPy8wAg--.3423S2;
	Mon, 14 Sep 2026 11:16:04 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	quchaosheng000406@163.com
Subject: Re: [PATCH] dt-bindings: iio: adc: xlnx,xadc: Convert to DT schema
Date: Mon, 14 Sep 2026 11:16:03 +0800
Message-ID: <20260914031603.439570-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914030226.437638-1-quchaosheng000406@163.com>
References: <20260914030226.437638-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3naXzZqdqPy8wAg--.3423S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy5Zw4kur1fKF4UXF1DKFg_yoW3tFbEk3
	ykK3y5Gan3Jrs29F1UKw4DZrn5ta1fWrn5Zr15Xr1avFy0yFn8Xa98twn3ZFyrGay8KFsx
	J3yfJFWjyrWjgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VU1znmtUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xVb0GqnZvXDxQAA3l

Hi all,

Please disregard this patch. I have just noticed that Sai Krishna
Potthuri already posted a conversion of this binding:

  [v2,4/4] dt-bindings: iio: adc: xlnx,axi-xadc: convert to DT schema
  https://patchwork.kernel.org/project/linux-iio/patch/20260323074505.3853353-5-sai.krishna.potthuri@amd.com/

That series is still marked as changes-requested, so the work is
already in progress and under review. I should have checked the list
before posting, and I apologise for the noise.

I am withdrawing my patch. I have not compared the two in detail, but
duplicating the review effort helps nobody, and his version is the one
that has already been reviewed.

Sai Krishna: if there is anything in my attempt that happens to be
useful to you, feel free to take it without attribution.

Thanks,
Quchaosheng

