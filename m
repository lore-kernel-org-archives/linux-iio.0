Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD806625;
	Thu,  2 Jul 2026 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950816; cv=none; b=csdsXUPpkjD3leLrTnWOxolAYWfwgLMQag2CNEaPZomyQn5FomLf+RSCVcmwDyxRvWifsVY6Q48XRzH3uTmxXSi7ShR5+Yt+s7+JGIgU7ubHHSg2u8WN0kAYmNZRUyDeFEMJYK+JCU5W0NyRomtttUNLSaVQ/LN0xmDsfOxkTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950816; c=relaxed/simple;
	bh=MEItSaorEtVMVl4PfCke0T/QOq4so2OgQJE+iM4o/Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZhqsmrBOBF44j7GTJ+J0xNs1nPOWKNPJlX9OH8c8pVAtHBU937EX+fcrdMBD0L/wduNHmX3hhwgqy21xp8epw8T5fwAbZ28wzpox6rJHp76gl4fEA2gxnP1YLbH8nGoUMiA4mL4V3T09vTD3+H65PkEsYkvUOWZdYmqqCcnduo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJhvGClO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJhvGClO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C71F00A3A;
	Thu,  2 Jul 2026 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950815;
	bh=mSSR/el782Jp7yT/vfA5wjZ9s2npmSxbMGUfKhRUwwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IJhvGClOgfGEXGzLui6nyMxsWckdcy0PVz9Hru2kuza+1Fm3Lak8L3amk4BZReFq2
	 PATH288YIwdiJO7pktXa6d+3fTe3TynOm1zOjlDwTHI/mBP6/xxbqQyXFWjb2iwN/C
	 OcEZDkEtcyqnlApURA3508MfgABp4TGoZUyCk5GhOsx220O7RP6fgqbNPHb/TcmL7K
	 lTHZJJrDb9XZ5cbtaLq1AjHtwQVKQ5pmmkZHFpUDm0liRYpNKp6VUqXUhRmh4izFM0
	 tf2HAgqwbr4idOjG0DDweXc2Idhl4d73ijD65SK41I6dy6px821xR+qzH3sE6lc7Bw
	 1P2ghDWTN1GNA==
Date: Thu, 2 Jul 2026 01:06:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 conall.ogriofa@amd.com, michal.simek@amd.com, linux@roeck-us.net,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v11 3/5] iio: adc: versal-sysmon: add I2C driver
Message-ID: <20260702010650.50e5ee4a@jic23-huawei>
In-Reply-To: <bcbd202e-7d43-4f59-9ff3-59b564e4a3f4@amd.com>
References: <20260623014036.3865402-1-salih.erim@amd.com>
	<20260623014036.3865402-4-salih.erim@amd.com>
	<bcbd202e-7d43-4f59-9ff3-59b564e4a3f4@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 12:33:33 +0100
"Erim, Salih" <salih.erim@amd.com> wrote:

> Addressing Sashiko findings on this patch:
> 
> - [High] Non-atomic I2C read transaction releases the bus lock,
>    making it vulnerable to bus interleaving.
> 
>    The SysMon I2C interface is typically on a dedicated bus with
>    no other devices. The current implementation works correctly
>    in all tested configurations. Switching to i2c_transfer() with
>    Repeated Start would match the TRM protocol diagram but would
>    require hardware testing on a board with I2C-accessible SysMon.
>    No change for now.
> 
To me this smells like a nice to have.  However, I agree with your
comment that it almost certainly doesn't matter.  Maybe one to add
to the backlog for next time any new features are being added to the driver.
