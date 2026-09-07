Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F32FDC53;
	Mon,  7 Sep 2026 01:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746109; cv=none; b=pajL1fHsRkS6L9qEWhIT7W/TOFxw1mgKICG6zXEevrGWHQvPx/HnrNMLz5vPndEP42GgUFGU0IEJQM2Ef9evdGLeRK7pzIFCWmIuLuizMKLgSplNwqIPJfXWUdSh/meTOKse/Bb3N8iuSR9vqpvl+Ic30y+bXEUo31zOyTRwb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746109; c=relaxed/simple;
	bh=8R/CfqYWTQfvNXgYK3zuYlxu1Qoo/PNu+eMlwsmAlYo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Q+W6TSqGXGsXxZPG0NGDfNPiAkS112lJa6mk9WEMTkSnCj9QcUcpuE3i+wUcmbxJ13altNwIDJQsdXZhnPi5dFU8OYY46cISOHwMUIjF2HtDMJP0f9Y1pvf3bMNh+pLnW+XzA0ppq3Efiu0CJAHIAIWcNr0Xb/AMOxm1UwTCwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNgBGXxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNgBGXxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47741F00ADB;
	Mon,  7 Sep 2026 01:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746105;
	bh=XSSRvMGyvcrCwzL4nAMkeT6VrCQ4EQbrIfUsmtSiuOc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bNgBGXxiFGH5/S9Ccm/oe6+DkWGo4oRbTz3W+GBXlO4chz9PtFLun5RgGy7PgTvBv
	 9FKK10+rJufIrWyIu1clQNWfnqfWQa3V1ys0C4nt/bRPlNQhVST1musqmO2tE870Nx
	 r5JfBs3/CkKYV9eh9LEZJMZUGTKtZjDLlqwumfSd6MK9SlwaP0fVKKgR/pRzFDybTU
	 KsQjqCkxRmvcPuqRcTI1+19QxunS4On6ijDw1dz9XvSr74tNJUKcmeV4GYkZ9Y4uxU
	 ig6fmEsVc9nYKTe/j6HTghrXHjJS750UfWNad2yv3npMnAPJTa/nkJbC6hLSnYXVhs
	 Y0M68oWBZ0Z6w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 6/8] iio: imu: inv_icm42607: Implement MREGx
 register access
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260901-b4-inv_icm42370p-v3-6-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-6-77cc31642115@axis.com>
Date: Mon, 07 Sep 2026 02:54:51 +0100
Message-Id: <178874609182.3402141.4593883108807688637.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=789;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=8R/CfqYWTQfvNXgYK3zuYlxu1Qoo/PNu+eMlwsmAlYo=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnhlupiYv3oAsDd8nYxr1nneMTvCMFQ+QfcJLF
 RPrFJnK53SJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap4ZbhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiFaAD/9Lok2f1BhAdbnB/BGpGltiXM8RpEYkavFmJrNBdzbXG1y
 UDA4h3jljAMa4aj6r96Rfp88w04f/Tk6XoX1YojLWMRpSzJmp68R9C0vd2u20QP1j1pqrOQGJD+
 DhaoyA0aHtqW5MmV8U2ynD7BUl18Y8Oq5B/acPJlQQgFPtDtvnZr9ayLMlwA5TiuN7CxVKj/rky
 Vt27hzekQDF9ASBM0QFP+WtTp/33aqTUAtr8udcbKFCnszaL8NMI8C9TF+iEyjF1J0Iqy1nfT+g
 9M13BxXDcutauVbVtPvx0eXJfyMNgRQPg14DcqNDJl7WOoL3gQ3g27qoQBGbZBkRN85VhmzEHhj
 HAKzzd8IqTzq50N7QodSFALD3BkhjTLi45f2DrTM6YkaJotG8pBqymJpIotfnq/YG5vESi+3dgK
 qXLkepTPhfUiX1owlKp7D0233CAEb1KI6RMazCXtNTfltV+D6MApJ27EzsQSsr+lNUbiDZYPrOT
 NyXiNq6yY34+HDhfR2GmU1UBWn11ll2BnAos54l/P0BUbpSkNgmbRSlCDMG3AKL7PHUXIaIgUhq
 v7EAW33Cyj4cwNTcCTPdYBOEBarXcz8cvv1Nxw4dCOGYtWG6qS/A+JufuuEWraUbPlseVrgUyIx
 QZiYBBroUIPO3kIwUV+8IYX21Xx+7PM0me3ykKg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> The device supports indirect register access to different banks. A
> specific routine needs to be followed when accessing the registers in
> another bank as documented in the datasheet (section 13). This is
> required for accessing registers configured via the user and
> implementing buffer support.
There were a few sashiko comments on this one. Make sure to take a
look:
https://sashiko.dev/#/patchset/20260901-b4-inv_icm42370p-v3-0-77cc31642115%40axis.com
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Assisted-by: LLM
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>

Nothing else from me.

J

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
