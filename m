Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AA28CF5E;
	Sun, 12 Oct 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760280950; cv=none; b=HVetA402cflDILoeqLgpP+5LizdgZNjjA9oxuNSGTlmSEqkxJlHTLk3WSAacLUbMRXRuHqj11VmhqAYTvU6LeO7xtz1cNeTu6LslfDmSG4jEnQ3noRuYC3qU1EaB6R2AcI/2PjKAnre972DATbJRVJ/9YBym9HFHJrs4NSAvkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760280950; c=relaxed/simple;
	bh=4HKT0zcNOyhNS1KCoK8RHZ+sLRB/kh1WqHwGUyNRpf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRvREYlnv2598/qGhn+NWDS4qx9A+7eGrevzZYA5gwEzl0wQyYcIQfEvFY+s+8j+s69V8hqMHVMtYuMewhgSxg0i2vq1hvOs1eM/KFjsRs5Ug2i3eGak/VPn8aDYCKSSvJsIy9dzL6HJ0G/YeKDZeLzr/sGrOQ52KLGFuW9dq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQjvTCEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQjvTCEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB71C4CEE7;
	Sun, 12 Oct 2025 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760280949;
	bh=4HKT0zcNOyhNS1KCoK8RHZ+sLRB/kh1WqHwGUyNRpf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sQjvTCEO/2F0HMy4O+tnSws35GYZYtrHD+Q8DnwoemqqZiDaO+pXGWMNEheTSMtlA
	 bfyCmt849nOsHe8l9nK91NxgIQ1I/vzL2XasOr75oy7Px1VeprAtrqFSL9s8sTodwc
	 FLp4WJ4ns/hJiw5IaSH6EYlVREmxhq/JxtW4dgvVo7cI8fyCiXn2UW4XGMnzG9qOX3
	 vg5/M45c5SweZ9BiEq8JUzqIMaIxzsoTMADe4yQvozPMzcvXy2qIzCypFD+0vm2pF5
	 mRD+cLjwsit+xZGOC6+26JDFv4RslBxE54o3GJcKbcRKZC8XaZpJN1tygwxfZZZEmk
	 S7Gdy870OBgkg==
Date: Sun, 12 Oct 2025 15:55:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/19] iio: accel: bma220: turn power supplies on
Message-ID: <20251012155544.47717398@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-9-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-9-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:18 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add devm_regulator_bulk_get_enable() to device probe().
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied. Thanks!
