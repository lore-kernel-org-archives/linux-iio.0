Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4A4334A3;
	Fri, 24 Jul 2026 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888574; cv=none; b=SyIhdj7oaguuQUSZjvf2Td5j4F3DayfaWPE/JKmAsZrQXpI2gKJ8V8Asl6xqaFD/MPxf0WyK1EfTaSMqKSU7c+rgokSqjTAMz5KCAsz4ubm6abPz3AEpL57hQulVCnj9s2rLZiTblEFemEcyyj4YZexhQzClGfGr2qALkmG5CMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888574; c=relaxed/simple;
	bh=GWadg1EQWDySCo5T4hvH7Z6S3cXtf/W8PrN6MNY+IcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDxYkmWZG1/2iindQd0Xs5iTeO6SXLLXKGo1ti3rXtvhHu7bWymWHmFxsVsht45Bt7PLrwqbyVaug/M0KHsd0cSM9Pn11SnSRuWdGDseRoaxCitES0LT2nRRt9MgKcpXXdE1hCNI5L/qldvg4YMv6kIqG3PUsYSLAEsdG/sr8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9Hh+QAJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9Hh+QAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD3E1F000E9;
	Fri, 24 Jul 2026 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784888572;
	bh=B/QZrNztN7mxBr7a1VoyHoziaj+i+NOGno+VpRywPtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9Hh+QAJE4TydNK4yQfH43zqUMJJ9ecBUWnZycxpWeLTTZqcsPYQ8GPO1duk4BaLs
	 FLyS7ZAcRs49r09LnhiAQ8RY3hSOkawjAwvdwk+rEoEbeeQ0u/qBVejO7vBqwJ1qLD
	 Q6VWOToars1/xvnXq1ZTqw71d0Ct7phbmYrLqV7pmsoUXgNYBKl+DyWE2oVnfOjlEO
	 BJjS9ohmewS8ygDtqp5Y9SQEZSihR9KfEuIS8lsgI9fT8Mxhm680p7BXL4hjNecX7x
	 06iX+Vup8BRjgcUt/ATaDGEfwSxI6/43eLi78IINuaz+a5nuNpDm5HPeb6posqs0LW
	 aeq5z2Hg6RYHQ==
From: William Breathitt Gray <wbg@kernel.org>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linusw@kernel.org,
	andriy.shevchenko@intel.com,
	mwalle@kernel.org,
	brgl@kernel.org,
	tychang@realtek.com,
	mathieu.dubois-briand@bootlin.com,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	dakr@kernel.org,
	bhelgaas@google.com,
	o-takashi@sakamocchi.jp,
	dlechner@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	cy.huang@realtek.com,
	james.tai@realtek.com
Subject: Re: [PATCH v7 5/9] gpio: regmap: Add gpio_regmap_operation to extend reg_mask_xlate callback
Date: Fri, 24 Jul 2026 19:22:45 +0900
Message-ID: <20260724102246.1126107-1-wbg@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723034237.2501507-6-eleanor.lin@realtek.com>
References: <20260723034237.2501507-6-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=643; i=wbg@kernel.org; h=from:subject; bh=GWadg1EQWDySCo5T4hvH7Z6S3cXtf/W8PrN6MNY+IcY=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFnJNg88j/NJ2Wxn2/Gx6eaJ77dX3tfZqcisZ3I7Y/Yrv atb9NPmd5SyMIhxMciKKbL0mp+9++CSqsaPF/O3wcxhZQIZwsDFKQATYVvP8D/Tt0M2Y3ee3WnX VrmEN343XnVOjHl8YkNCMaesjnZs5xZGhvYpRr82N6iUbQjwc2lkO179a8vKFQ5SWzLtqhLuCic asAAA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Thu, Jul 23, 2026 at 11:42:22AM +0800, Yu-Chun Lin wrote:
> Extend the reg_mask_xlate callback with an operation type parameter
> (enum gpio_regmap_operation) to allow drivers to return different
> register/mask combinations depending on the specific GPIO operation.
> 
> Consequently, update all existing drivers utilizing the gpio-regmap
> framework (across drivers/gpio, drivers/iio, and drivers/pinctrl)
> to accommodate the new reg_mask_xlate function signature.
> 
> Suggested-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

Acked-by: William Breathitt Gray <wbg@kernel.org>
