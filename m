Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547876;
	b=mMWmAFk+N1eyLp1pVvhvPAoM3ojNDlmt/RMiX/n4+77gWBIekt16c8D04r3WT/+axiu8
	 +PvNg7n40KlV9yENbkKYjWCju+y65pBf0utSvtMZxJoVOQW9aRVOD4FBQ9U6wxqDvb8ux
	 UhBODk3JyOgXguZTpVvezcyJSj43L1pi41cvBwtzR/TWTZ//6RuXpCkPZUIBBXDpb/Ox8
	 +hVizAAwBIfzNhv1mGjcYQOLBXXTXcUUPbdmjUkZkIJtNVH6YTcbdEAyWS13hHFXsRNec
	 cldGv+6VPLE5lg3fm9GZVzcZslYspmaI9Hb4dGbruY+RDzbShxVNrdzlf312kUpbwUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=gcl52OyN1m2WWYUZ+pSWvNBJXOOulD3DS6ddleVJd3Q=;
	b=zwz0G4PAfP8FVT/t6iRRo6/wzkwag7t6ahHtnb1fCAyDq5vNxPftvedbMhKvuapqTltU
	 wH+fGpho3I3p1yL4SHiu6N4NXA7RWDSPZJ8hN08bI/BwfIGetUYoPD9hAgDhtGpuk/8yI
	 S1aQJvqRmPNxYN5ync2ICXqKmuN774Y4hxeT3olzK9XOi8l5Rbvb3dhUnQMhbAb6aF8CX
	 YOnH+WfwgcocHPTlEFQOSULbCoRMImAJ5B6Wqq9nfrtt8DUY0jdgsdsVwMU8PCOdXpJCl
	 5/Dmxxqd8QIHl52HVj8h9nH+JIMs5++tStZVMejef4INonsfe1TIDLGHI+XpBp0jAWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmCcMoR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2F606A31E;
	Tue, 24 Nov 2026 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmCcMoR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7971F000C4;
	Tue, 24 Nov 2026 19:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795547875;
	bh=gcl52OyN1m2WWYUZ+pSWvNBJXOOulD3DS6ddleVJd3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XmCcMoR3ZwZmap7V7dM7j8NjVj+8aGo8FlxbuZLOrQstX9BsUa+IJpFtNLK4kaqob
	 Rd9m+g7Pfkq/xA1/r6C2gl3K3Ynp/7e0J4+YzscGEb++HSPjdM8niUUn86Kjme3znZ
	 PvYQ77lWl9uH8Z8/4svrBdoSIlLX6FX6ye0nDsYx9ibWDL6ybWyZKX0XtcEpnNDPWj
	 GrzepTzPFMnl1HZ4NVZdPJVHbdd4rbVQeZxoYMqHbxAGaZYBPyXhYgcjcHc1ubB5dH
	 DvvmZ3NpPc2ddtPAX1v39sAWN2/hyUEWe7t5xnkIBAjWZzGvHGfN4V6bg7lnr3KxAT
	 nHtV8E7NCd0NA==
From: William Breathitt Gray <wbg@kernel.org>
To: fabrice.gasnier@foss.st.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/counter: Reject invalid watch fields before narrowing
Date: Tue, 24 Nov 2026 14:17:50 -0500
Message-ID: <179554784897.2331239.17103713083473647730.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120061932.98210-1-zhujun2@cmss.chinamobile.com>
References: <20261120061932.98210-1-zhujun2@cmss.chinamobile.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=548; i=wbg@kernel.org; h=from:subject:message-id; bh=MlP3KAFXB3D6AAi5PMLISvGWnS/pWnv4aOG1kGYqMzA=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDNmsj841lyd9Xrg2oyCzl+18wHKOIwbyDFUvz1g0HJ6uP z85we17RykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRn+qMDM+ClSsrD770yvAT cBPkmfH7ncuU5w6XLRze3V9iuUuI05WRYRrfX9tDZSlKS+vDT3Rmy+7wczdx9ji+4xCnzr1UKw5 xdgA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Fri, 20 Nov 2026 14:19:32 +0800, Zhu Jun wrote:
> The channel, component ID and parent fields are all eight bits wide.
> The current parser accepts trailing characters and silently narrows
> values above 255, which can select the wrong counter watch. Parse
> these fields before assignment and only accept a value in range.
> 
> 

Applied, thanks!

[1/1] tools/counter: Reject invalid watch fields before narrowing
      commit: 0fdd4e1bdaa9084785280ce233fd3ddab04ff9cc

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
