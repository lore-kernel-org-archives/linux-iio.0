Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842D10F1;
	Mon, 21 Sep 2026 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789948926; cv=none; b=HofZpfRjtgr8AQtvZOSdlh80KIixoaEf0bgtfvIJka2dALLDCDYCtpndmlE0UmtX00USof+wSMHyTtDRa64c8egneNjBgjcVy3HaLKrzg4M6S+YDIdAsjUCzloZbSMuYSKUfJYLtMCJqTVnEOcoBlbPHGFzU9v8PFWVaWpzsTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789948926; c=relaxed/simple;
	bh=TNPsjX6JC2Hr/EajqsgnDzgUP1rBmYUdERS1dDZSk9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTIz8BBThjXydaIvk+3fHYKjzTtWjlJHHCLGw9o76tA8G8q72paQyrljF8FWm11VJ4V5JLUM0wBoOkYCGGT1/03g8I0pkvnDrL1TSVSPN90KFYA+QKULpGMi0NUu+Ztw4aWytcb3Zb/d9x0zJVTRMZhoYI/2QoJjq1TLO9HX1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXeMSxh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXeMSxh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597371F000FF;
	Mon, 21 Sep 2026 00:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789948925;
	bh=zbr4iDA5Vtjtl5nlaUrT86DbarQNmUdKGR6cDe3nG8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dXeMSxh3APB64EKUXd6tdncDTIXG+VOdFMEEhu0PmKu4ToeUNByAoYxVek7zEQnfp
	 Q2Nko6A3A7E5XFbdFmtxzoBiZrMofFV3i5jsRVbzOqfSr7iAHRlOTz8qPZGiKJiTUj
	 9VHxZOUIo2b6yNbQLwdq1U5S7Ric6yxuYz40PH+/DavzwDyRPMTNu5roD611HQ4wsI
	 11wKtMA1tCq1HlosD8sFHgRzxM2Twd1rBzaiyAEaD2lMU31hSj6MSvAOOi8oJ4I9n0
	 v/7Lb18MFiwH/e3kU9DK26IjpaAADcXL7HNS928CP6gEUVLTKgM0qV4c8snhJ5e5us
	 7xWize+QTRocA==
Date: Mon, 21 Sep 2026 01:01:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: iio: backend: use literal block for commands
Message-ID: <20260921010159.2e518478@jic23-hlaptop>
In-Reply-To: <20260916180739.2296401-1-rdunlap@infradead.org>
References: <20260916180739.2296401-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 11:07:39 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Use literal blocks for 'cat' and 'echo' commands to separate them from
> the surrounding text. Otherwise the lines run together, without any
> clear break before or after the commands.
> 
> Use shell comment style to go along with the shell commands.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Applied.  Thanks

Jonathan
