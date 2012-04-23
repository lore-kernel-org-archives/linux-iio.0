Return-Path: <swarren@wwwdotorg.org>
Message-ID: <4F958E42.6030506@wwwdotorg.org>
Date: Mon, 23 Apr 2012 11:15:46 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Laxman Dewangan <ldewangan@nvidia.com>
CC: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net,
 linux@arm.linux.org.uk, jic23@cam.ac.uk, gregkh@linuxfoundation.org,
 swarren@nvidia.com, olof@lixom.net, devicetree-discuss@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2 3/4] ARM: dt: tegra: enable als and proximity sensor
References: <1335183097-21104-1-git-send-email-ldewangan@nvidia.com> <1335183097-21104-5-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1335183097-21104-5-git-send-email-ldewangan@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/23/2012 06:11 AM, Laxman Dewangan wrote:
> Add the device info for ALS and proximity sensor for tegra
> boards cardhu, ventana and seabridge.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Thanks, applied.

I made the following minor changes: s/PZ02/PZ2/ in .dts files,
s/seabridge/seaboard/ in commit description

I note that the proximity detection doesn't appear to work on my Cardhu,
although the light sensor works. Is that expected? Both work on Seaboard
and Ventana.
