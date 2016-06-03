Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:38769 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcFCIUl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 04:20:41 -0400
Subject: Re: [PATCH] Dyna-Image AL3320A update, add AL3010 driver
To: Rocky Hsiao <rocky.hsiao@dyna-image.com>,
	linux-kernel@vger.kernel.org
References: <1464926549-43040-1-git-send-email-rocky.hsiao@dyna-image.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Olof Johansson <olofj@chromium.org>,
	Filipe Brandenburger <filbranden@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sonny Rao <sonnyrao@chromium.org>,
	Daniel Kurtz <djkurtz@chromium.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Matt Ranostay <mranostay@gmail.com>,
	Puthikorn Voravootivat <puthik@chromium.org>,
	Andreas Dannenberg <dannenberg@ti.com>,
	linux-iio@vger.kernel.org, John Huang <john.huang@dyna-image.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <57513DD5.3060507@metafoo.de>
Date: Fri, 3 Jun 2016 10:20:37 +0200
MIME-Version: 1.0
In-Reply-To: <1464926549-43040-1-git-send-email-rocky.hsiao@dyna-image.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/2016 06:02 AM, Rocky Hsiao wrote:
> 1. Change al3320a.c to match light sensor test flow.
> 2. Add al3010.c to add new device AL3010.
>    original file copy from al3320a.c

Hi,

Thanks for the patch. In addition to what Daniel said, for upstream patch
submissions it is important to have proper commit messages explaining what
is done, why it is done and how it is done. The commit messages should
follow the general style of the subsystem you are sending the patch to. E.g.
in the IIO case this means that the subject line should start with "iio: ...".

http://chris.beams.io/posts/git-commit/ is a very good document that
describes how to create a good commit message and I recommend reading it.

- Lars

