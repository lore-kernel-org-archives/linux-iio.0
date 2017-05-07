Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57608 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbdEGWVB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:21:01 -0400
Subject: Re: [PATCH 1/2] tsl2x7x_core: remove paragraph about writing to the
 FSF's mailing address
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Brian Masney <masneyb@onstation.org>
References: <20170504203832.5525-1-eballetbo@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6a117702-e456-1ec9-0b71-f302a6b351ad@kernel.org>
Date: Sun, 7 May 2017 13:51:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170504203832.5525-1-eballetbo@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/05/17 21:38, Enric Balletbo i Serra wrote:
> Do not include the paragraph about writing to the Free Software
> Foundation's mailing address from the sample GPL notice. The FSF
> has changed addresses in the past, and may do so again. Linux
> already includes a copy of the GPL.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

I dealt with the fact this crossed with a file rename patch and
the file is now called tsl2x7x.c

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index ea15bc1c300c..b35ff63f7f60 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -13,10 +13,6 @@
>   * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>   * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>   * more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write to the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA        02110-1301, USA.
>   */
>  
>  #include <linux/kernel.h>
> 

