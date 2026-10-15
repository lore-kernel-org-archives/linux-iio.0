Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB349EC7F;
	Thu, 15 Oct 2026 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066683; cv=none; b=AqSYSsK3RyniJxdhO5Gpfb6YQ7TgJGiiHj8S4fqhiI2oBqs8TsnEjU6U0QcFO9R+XgLw0Gs8Gxuq9W9P+RGy8HD0JSlvwHguXz5y82vODMgSpxRDsqJO2UxBBGoDy/0DsN2KjGh6zeoJY1nfS+Emw1yvjS0yitvWupGFVmUZSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066683; c=relaxed/simple;
	bh=+fB34VuA7wpq6empWyJXVqzOVhVPkE7LZbcucVhE93Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XQUq1key53WrNEWu+DxCCMSHsWb850Jm5W7WaThjFMZv6ziAiHVcd09o4MoJgX5QUn73/v0rr+nkd47kBw7cr9PU/JhHSUkNbG7fPqhroeWbQOtX/gCh5hm02ekeXdKbVs0CrM4W0UPMNJz4ErRTVOPh0O72x6njaf5hxdM4G4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIecqfOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIecqfOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE7E1F000C5;
	Thu, 15 Oct 2026 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792066681;
	bh=qVEreEp0Hw8z9be2U0iUr/ECSYHh9yfdw1fSZ6anxtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RIecqfOYt+nhoWwYu4s36KbOZQFld7TG/yeZsEz7i8hA2zroCZdfTU0tlxfDKa8gE
	 VomsFUpwcjXV9TyKq4ZOnLV8fCdd/1W5pkgS6fqnsPh8N3u426OQiptvlO2uXmDRrl
	 I1opyKbXyIglmsQxVUrTfIrRB5TLj9grUP9nOM/+lW7qXTJpzurUwbJkHJkllXZSU9
	 m0w19amKjxkvMNkG/BPjaQxZsxZq0W1Y5fQ69roYVfvG5iZnElgnKEARcoapKNldp6
	 exDjnjhR4fZ6n9HQe6ycHPbSE0jZp4aWWguUw6e9E7IRQ9lMILfb93NkQK5trbRe9+
	 TX/L7hjYN2frw==
From: Lee Jones <lee@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Ryan Brue <ryanbrue.dev@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, mfd@lists.linux.dev, 
 Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
In-Reply-To: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-3-23533a0d30e3@gmail.com>
References: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-3-23533a0d30e3@gmail.com>
Subject: Re: (subset) [PATCH v4 3/3] mfd: mt6397-core: Add mt6397 AUXADC
 support
Message-Id: <179206667779.1910726.5341177428334836457.b4-ty@b4>
Date: Thu, 15 Oct 2026 13:17:57 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 28 Sep 2026 15:57:21 -0500, Ryan Brue wrote:
> The mt6397 PMIC includes an AUXADC. Register the AUXADC in the mt6397
> devices array to allow the corresponding driver to probe using compatible
> string.

Applied, thanks!

[3/3] mfd: mt6397-core: Add mt6397 AUXADC support
      commit: cc6597f4e3b752de42249879e0c7054fd23628a1

--
Lee Jones [李琼斯]

