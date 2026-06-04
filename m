Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8E313E2C;
	Thu,  4 Jun 2026 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539556; cv=none; b=uhjssWKPoPUWMBKPKe2qQzSD2/AKl78odX1Xi+FO7oJtRLNJgDrEOER3WunnnrX7MFoQn4LESVmjJJrvyebzlP/IxKU9X9TPOChnzudoNusj1s5ns8YmJMNgmanwSrhe5swQrEjUyE9wQ0wl84VvZYiy0vaLWAv5Zt6qzejTB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539556; c=relaxed/simple;
	bh=P2KOM0zc+Co8PaZ2tb4c2FKzgypPaM+kr3SYzt3/9i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQPuJ1ohUkcCCYBc8cbjjWdPf72rVI1xxGY6qSYxIY2jHArCse8tAkO2RrmBZ6ZKPc3+s0KIHFK+B6oRFUvE9yPJF8gz1PbY33sThTs2Zpe49RNEIDCVpQRZDW66Pikd3NlS/fPUU6vN5QTVwJK+EUwD9neh0fIoeuC1PzbWQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF+7O6uG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF+7O6uG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B081F00898;
	Thu,  4 Jun 2026 02:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539552;
	bh=SlKEJhzt+Q2HWO5VQf4SWuo+Z5HxgK2SnVRUIT9hIvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aF+7O6uGxuc8IAdiqj0tRtmlOD+1KYOo920sdu4Co2s90XPl/WmiN8WstyUdJAX50
	 7LERLkGvHZ83ANKzamSshA996aiptzEZADmlrGiq3tOEIr9/4lSOtfXQ30b4U+OKvS
	 TLbUcOFKT4Z4lNfERBnFYYMslzplB5RFFiNSUj/iEZXycjLQec9PgOsDsa4W6xkXl4
	 q22L4wOHHx03RuEAtKE4/xskbw/ysfx3ezMs2nSuNhWsIvvD00EIZbXVxkmb45V+s6
	 eT9eMXV+hWht/PdlphbLoV/oVqQQLl7b4wTojRsfEgDAIDrMdlgYF1E0lsQ7Lv+VLk
	 btYv5Qh5REzxw==
From: William Breathitt Gray <wbg@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	m32285159@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] counter: ti-eqep: use devm for runtime PM to fix probe error path
Date: Thu,  4 Jun 2026 11:19:01 +0900
Message-ID: <20260604021902.891327-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529095834.2561-1-sozdayvek@gmail.com>
References: <20260529095834.2561-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=wbg@kernel.org; h=from:subject; bh=P2KOM0zc+Co8PaZ2tb4c2FKzgypPaM+kr3SYzt3/9i0=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFkKDxLWNyWm6OyQqp72ttCNz6cm0z+sq33zTgatjb/e5 tRd//K0o5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZgIQxkjw9za4Dv7fGLfLbqt Zv3b7JCZmxbrw+VHJigEy1guuNTuGMzw30urNd//BPP9paHmaxTnrzJWiL2yO+O55r1HumzfH7H OYAUA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Fri, May 29, 2026 at 02:58:34PM +0500, Stepan Ionichev wrote:
>  	err = counter_add(counter);
> -	if (err < 0) {
> -		pm_runtime_put_sync(dev);
> -		pm_runtime_disable(dev);
> -		return err;
> -	}
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "Failed to add counter\n");
> 
>  	return 0;
>  }
> @@ -564,11 +575,8 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  static void ti_eqep_remove(struct platform_device *pdev)
>  {
>  	struct counter_device *counter = platform_get_drvdata(pdev);
> -	struct device *dev = &pdev->dev;
> 
>  	counter_unregister(counter);
> -	pm_runtime_put_sync(dev);
> -	pm_runtime_disable(dev);
>  }

The ti_eqep_remove() callback can go away entirely if you use
devm_counter_add() to replace counter_add(). It's not really part of
this PM fix, but it is a nice clean up to simplify the code if you would
like to add a subsequent patch doing so after the PM fix.

William Breathitt Gray
